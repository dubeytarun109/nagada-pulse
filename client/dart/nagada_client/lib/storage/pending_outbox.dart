
import '../core/models/client_event.dart';

abstract class PendingOutbox {
  /// Adds a new event to the outbox.
  Future<void> add(ClientEvent event);

  /// Loads all events currently pending in the outbox.
  Future<List<ClientEvent>> pending();

  /// Removes events from the outbox that have been acknowledged by the server.
  Future<void> markAsSynced(List<String> clientEventIds);
}