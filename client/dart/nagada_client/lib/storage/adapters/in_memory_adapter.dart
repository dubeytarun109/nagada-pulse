import '../../core/models/client_event.dart';
import '../offset_store.dart';
import '../pending_outbox.dart';

class InMemoryAdapter implements OffsetStore, PendingOutbox {
  int? _offset;
  final List<ClientEvent> _outbox = [];

  @override
  Future<int?> get() {
    return Future.value(_offset);
  }

  @override
  Future<void> save(int offset) {
    _offset = offset;
    return Future.value();
  }

  @override
  Future<void> add(ClientEvent event) {
    _outbox.add(event);
    return Future.value();
  }

  @override
  Future<List<ClientEvent>> pending() {
    // Create a new list before sorting to avoid mutating the original.
    final sortedList = _outbox.toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return Future.value(List.unmodifiable(sortedList));
  }

 
  
  @override
  Future<String?> getOffset() {
     return Future.value(_offset?.toString());
  }
  
  @override
  Future<List<ClientEvent>> loadPending() {
    return pending();
  }
  
  @override
  Future<void> setOffset(String offset) {
    _offset = int.parse(offset);
    return Future.value();
  }
  
  @override
  Future<void> markAsSynced(List<String> clientEventIds) {
    _outbox.removeWhere((event) => clientEventIds.contains(event.clientEventId));
    return Future.value();

  }
}
