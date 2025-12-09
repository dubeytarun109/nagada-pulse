import '../../lib/nagada.dart';
import 'package:test/test.dart';

void main() {
  group('OffsetStore', () {
    late OffsetStore offsetStore;

    setUp(() {
      offsetStore = InMemoryAdapter();
    });

    test('Saves and retrieves offset', () async {
      await offsetStore.save(123);
      final offset = await offsetStore.get();
      expect(offset, 123);
    });

    test('Returns null when no offset is saved', () async {
      final offset = await offsetStore.get();
      expect(offset, isNull);
    });

    test('Overwrite behavior', () async {
      await offsetStore.save(123);
      await offsetStore.save(456);
      final offset = await offsetStore.get();
      expect(offset, 456);
    });

    test('Offset does not survive restart (with InMemoryAdapter)', () async {
      await offsetStore.save(100);

      // Simulate a restart by creating a new instance
      final newOffsetStore = InMemoryAdapter();
      final offset = await newOffsetStore.get();

      expect(offset, isNull);
    });
  });
}
