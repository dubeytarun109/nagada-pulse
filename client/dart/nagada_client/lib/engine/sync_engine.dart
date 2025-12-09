import 'dart:async';

import 'conflict_resolver.dart';
import '../core/models/server_event.dart';
import '../core/models/sync_request.dart';
import '../protocol/http_sync_transport.dart';
import '../storage/offset_store.dart';
import '../storage/pending_outbox.dart';

/// A callback function to apply server events to the local application state.
typedef ApplyEventsCallback = Future<void> Function(List<ServerEvent> events);

/// The core orchestrator for the synchronization process.
class SyncEngine {
  final String deviceId;
  final HttpSyncTransport transport;
  final OffsetStore offsetStore;
  final PendingOutbox outbox;
  final ConflictResolver conflictResolver;
  final ApplyEventsCallback onApplyEvents;

  bool _isSyncing = false;
  final _syncController = StreamController<void>.broadcast();

  SyncEngine({
    required this.deviceId,
    required this.transport,
    required this.offsetStore,
    required this.outbox,
    required this.onApplyEvents,
    ConflictResolver? conflictResolver,
  }) : conflictResolver = conflictResolver ?? ConflictResolver();

  /// A stream that emits an event whenever a sync cycle completes.
  Stream<void> get onSyncComplete => _syncController.stream;

  /// Triggers a single synchronization cycle.
  ///
  /// This involves sending pending local events to the server (push) and
  /// fetching new remote events from the server (pull).
  Future<void> runCycle() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final pendingEvents = await outbox.pending();
      final lastKnownId = await offsetStore.get() ?? -1;

      final request = SyncRequest(
        deviceId: deviceId,
        lastKnownServerEventId: lastKnownId,
        pendingEvents: pendingEvents,
      );

      final response = await transport.sync(request);

      if (response.ackedClientEventIds.isNotEmpty) {
        await outbox.markAsSynced(response.ackedClientEventIds);
      }

      // Filter out events that are older than or equal to the last known ID
      final newServerEvents = response.newServerEvents
          .where((event) => event.serverEventId > lastKnownId)
          .toList();

      final resolvedEvents = conflictResolver.resolve(newServerEvents);
      if (resolvedEvents.isNotEmpty) {
        await onApplyEvents(resolvedEvents);
      }

      final maxId = resolvedEvents
          .map((e) => e.serverEventId)
          .fold(lastKnownId, (max, id) => id > max ? id : max);

      await offsetStore.save(maxId);
      _syncController.add(null);
    } finally {
      _isSyncing = false;
    }
  }

  void dispose() {
    _syncController.close();
  }
}