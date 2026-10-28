class Client {
  final String id;
  final String name;
  final String? phone;
  final String? address;
  final String? measurements;
  final String? notes;
  final DateTime createdAt;

  Client({
    required this.id,
    required this.name,
    this.phone,
    this.address,
    this.measurements,
    this.notes,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'address': address,
        'measurements': measurements,
        'notes': notes,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Client.fromMap(Map<String, dynamic> map) => Client(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        phone: map['phone'],
        address: map['address'],
        measurements: map['measurements'],
        notes: map['notes'],
        createdAt: DateTime.parse(map['createdAt']),
      );

  Client copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    String? measurements,
    String? notes,
    DateTime? createdAt,
  }) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      measurements: measurements ?? this.measurements,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
