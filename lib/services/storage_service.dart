import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/order.dart';
import '../models/client.dart';
import '../models/stock_item.dart';

class StorageService {
  static late SharedPreferences _prefs;
  static const _uuid = Uuid();

  static const _ordersKey = 'orders';
  static const _clientsKey = 'clients';
  static const _stockKey = 'stock';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String newId() => _uuid.v4();

  // ---------- ORDERS ----------
  static List<Order> getOrders() {
    final raw = _prefs.getString(_ordersKey);
    if (raw == null || raw.isEmpty) return [];
    final list = json.decode(raw) as List;
    return list.map((e) => Order.fromMap(e)).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  static Future<void> saveOrders(List<Order> orders) async {
    await _prefs.setString(_ordersKey, json.encode(orders.map((e) => e.toMap()).toList()));
  }

  static Future<void> addOrder(Order order) async {
    final list = getOrders();
    list.add(order);
    await saveOrders(list);
  }

  static Future<void> updateOrder(Order order) async {
    final list = getOrders();
    final i = list.indexWhere((o) => o.id == order.id);
    if (i != -1) {
      list[i] = order;
      await saveOrders(list);
    }
  }

  static Future<void> deleteOrder(String id) async {
    final list = getOrders()..removeWhere((o) => o.id == id);
    await saveOrders(list);
  }

  // ---------- CLIENTS ----------
  static List<Client> getClients() {
    final raw = _prefs.getString(_clientsKey);
    if (raw == null || raw.isEmpty) return [];
    final list = json.decode(raw) as List;
    return list.map((e) => Client.fromMap(e)).toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  static Future<void> saveClients(List<Client> clients) async {
    await _prefs.setString(_clientsKey, json.encode(clients.map((e) => e.toMap()).toList()));
  }

  static Future<void> addClient(Client client) async {
    final list = getClients();
    list.add(client);
    await saveClients(list);
  }

  static Future<void> updateClient(Client client) async {
    final list = getClients();
    final i = list.indexWhere((c) => c.id == client.id);
    if (i != -1) {
      list[i] = client;
      await saveClients(list);
    }
  }

  static Future<void> deleteClient(String id) async {
    final list = getClients()..removeWhere((c) => c.id == id);
    await saveClients(list);
  }

  // ---------- STOCK ----------
  static List<StockItem> getStock() {
    final raw = _prefs.getString(_stockKey);
    if (raw == null || raw.isEmpty) return [];
    final list = json.decode(raw) as List;
    return list.map((e) => StockItem.fromMap(e)).toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  static Future<void> saveStock(List<StockItem> items) async {
    await _prefs.setString(_stockKey, json.encode(items.map((e) => e.toMap()).toList()));
  }

  static Future<void> addStockItem(StockItem item) async {
    final list = getStock();
    list.add(item);
    await saveStock(list);
  }

  static Future<void> updateStockItem(StockItem item) async {
    final list = getStock();
    final i = list.indexWhere((s) => s.id == item.id);
    if (i != -1) {
      list[i] = item;
      await saveStock(list);
    }
  }

  static Future<void> deleteStockItem(String id) async {
    final list = getStock()..removeWhere((s) => s.id == id);
    await saveStock(list);
  }

  static Future<void> deductMaterials(Map<String, int> used) async {
    final stock = getStock();
    for (final entry in used.entries) {
      final i = stock.indexWhere((s) => s.name.toLowerCase() == entry.key.toLowerCase());
      if (i != -1) {
        final newQty = (stock[i].quantity - entry.value).clamp(0, 999999);
        stock[i] = stock[i].copyWith(quantity: newQty);
      }
    }
    await saveStock(stock);
  }
}
