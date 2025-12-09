abstract class OffsetStore {
  /// Retrieves the last known server event offset. Returns null if no offset is stored.
  Future<int?> get();

  /// Persists the last known server event offset.
  Future<void> save(int offset);
}