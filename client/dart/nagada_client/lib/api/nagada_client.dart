import 'dart:async';

import '../storage/adapters/in_memory_adapter.dart';
import '../protocol/http_sync_transport.dart';
import 'package:uuid/uuid.dart';

import '../core/models/client_event.dart';
import '../core/models/server_event.dart';
import '../engine/conflict_resolver.dart';
import '../engine/sync_engine.dart';
import '../storage/offset_store.dart';
import '../storage/pending_outbox.dart';

/// A callback to handle incoming server events.
/// The implementation should apply these events to the local data store.
typedef OnNewEventsCallback = Future<void> Function(List<ServerEvent> events);

/// Placeholder for a record change event.
class RecordChangeEvent {}

/// The main public-facing API for interacting with the Nagada sync service.
abstract class NagadaClient {
  factory NagadaClient.create({
    required String deviceId,
    required String serverUrl,
    ConflictResolver? conflictResolver,
  }) {
    final transport = HttpSyncTransport(serverUrl: serverUrl);
    final storage = InMemoryAdapter();
    return NagadaClientImpl(
      deviceId: deviceId,
      transport: transport,
      offsetStore: storage,
      outbox: storage,
      conflictResolver: conflictResolver,
    );
  }

  /// Triggers a synchronization cycle with the server.
  Future<void> sync();

  /// Inserts data for a given table, creating an event to be synced.
  Future<void> insert(String table, Map<String, dynamic> data);

  /// A stream that emits record changes for a given table.
  Stream<RecordChangeEvent> onChange(String table);

  /// Disposes of the client and releases any resources.
  void dispose();
}


/// The default implementation of [NagadaClient].
class NagadaClientImpl implements NagadaClient {
  late final SyncEngine _engine;
  final PendingOutbox _outbox;
  final Uuid _uuid;
  final _eventsController = StreamController<List<ServerEvent>>.broadcast();

  NagadaClientImpl({
    required String deviceId,
    required HttpSyncTransport transport,
    required OffsetStore offsetStore,
    required PendingOutbox outbox,
    ConflictResolver? conflictResolver,
    Uuid? uuid,
  })  : _outbox = outbox,
        _uuid = uuid ?? const Uuid() {
    _engine = SyncEngine(
      deviceId: deviceId,
      transport: transport,
      offsetStore: offsetStore,
      outbox: outbox,
      onApplyEvents: _handleNewEvents,
      conflictResolver: conflictResolver,
    );
  }

  @override
  Stream<RecordChangeEvent> onChange(String table) {
    // TODO: Implement filtering events by table and transforming to RecordChangeEvent
    return _eventsController.stream.map((events) => RecordChangeEvent());
  }

  @override
  Future<void> sync() => _engine.runCycle();

  @override
  Future<void> insert(String table, Map<String, dynamic> data) {
    final event = ClientEvent(
      clientEventId: _uuid.v4(),
      type: table, // Using table as event type for now
      payload: data,
    );
    return _outbox.add(event);
  }

  Future<void> _handleNewEvents(List<ServerEvent> events) async {
    if (events.isNotEmpty) {
      _eventsController.add(events);
    }
  }

  @override
  void dispose() {
    _eventsController.close();
    _engine.dispose();
  }
}
