class Outbox {
  final List<Map<String, dynamic>> _items = [];

  void add(Map<String, dynamic> event) => _items.add(event);

  List<Map<String, dynamic>> flush() {
    final items = List<Map<String, dynamic>>.from(_items);
    _items.clear();
    return items;
  }
}
