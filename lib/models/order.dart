import 'dart:convert';

class Order {
  final String id;
  final String clientId;
  final String clientName;
  final String nailType;
  final String size;
  final String? notes;
  final double price;
  final DateTime createdAt;
  final DateTime? makeDate;
  final DateTime? dispatchDate;
  final String paymentStatus; // Unpaid | Paid
  final String status; // Working | Ready | Dispatched | Delivered
  final String? address;
  final String? photoPath;
  final Map<String, int> materialsUsed; // materialName -> qty

  Order({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.nailType,
    required this.size,
    this.notes,
    required this.price,
    required this.createdAt,
    this.makeDate,
    this.dispatchDate,
    this.paymentStatus = 'Unpaid',
    this.status = 'Working',
    this.address,
    this.photoPath,
    this.materialsUsed = const {},
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'clientId': clientId,
        'clientName': clientName,
        'nailType': nailType,
        'size': size,
        'notes': notes,
        'price': price,
        'createdAt': createdAt.toIso8601String(),
        'makeDate': makeDate?.toIso8601String(),
        'dispatchDate': dispatchDate?.toIso8601String(),
        'paymentStatus': paymentStatus,
        'status': status,
        'address': address,
        'photoPath': photoPath,
        'materialsUsed': materialsUsed,
      };

  factory Order.fromMap(Map<String, dynamic> map) => Order(
        id: map['id'] ?? '',
        clientId: map['clientId'] ?? '',
        clientName: map['clientName'] ?? '',
        nailType: map['nailType'] ?? '',
        size: map['size'] ?? '',
        notes: map['notes'],
        price: (map['price'] ?? 0).toDouble(),
        createdAt: DateTime.parse(map['createdAt']),
        makeDate: map['makeDate'] != null ? DateTime.parse(map['makeDate']) : null,
        dispatchDate: map['dispatchDate'] != null ? DateTime.parse(map['dispatchDate']) : null,
        paymentStatus: map['paymentStatus'] ?? 'Unpaid',
        status: map['status'] ?? 'Working',
        address: map['address'],
        photoPath: map['photoPath'],
        materialsUsed: Map<String, int>.from(map['materialsUsed'] ?? {}),
      );

  Order copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? nailType,
    String? size,
    String? notes,
    double? price,
    DateTime? createdAt,
    DateTime? makeDate,
    DateTime? dispatchDate,
    String? paymentStatus,
    String? status,
    String? address,
    String? photoPath,
    Map<String, int>? materialsUsed,
  }) {
    return Order(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      nailType: nailType ?? this.nailType,
      size: size ?? this.size,
      notes: notes ?? this.notes,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      makeDate: makeDate ?? this.makeDate,
      dispatchDate: dispatchDate ?? this.dispatchDate,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      status: status ?? this.status,
      address: address ?? this.address,
      photoPath: photoPath ?? this.photoPath,
      materialsUsed: materialsUsed ?? this.materialsUsed,
    );
  }
}
