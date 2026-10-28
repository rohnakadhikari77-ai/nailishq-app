class StockItem {
  final String id;
  final String name;
  final int quantity;
  final String? unit; // pcs, pack, etc.
  final String? notes;

  StockItem({
    required this.id,
    required this.name,
    required this.quantity,
    this.unit,
    this.notes,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'unit': unit,
        'notes': notes,
      };

  factory StockItem.fromMap(Map<String, dynamic> map) => StockItem(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        quantity: map['quantity'] ?? 0,
        unit: map['unit'],
        notes: map['notes'],
      );

  StockItem copyWith({
    String? id,
    String? name,
    int? quantity,
    String? unit,
    String? notes,
  }) {
    return StockItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      notes: notes ?? this.notes,
    );
  }
}
