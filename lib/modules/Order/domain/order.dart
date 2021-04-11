import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:lista_de_compras/modules/Cart/domain/cart_item.dart';

class Order {
  final dynamic id;
  final double total;
  final List<CartItem> products;
  final DateTime date;
  Order({
    this.id,
    this.total,
    this.products,
    this.date,
  });

  Order copyWith({
    dynamic id,
    double total,
    List<CartItem> products,
    DateTime date,
  }) {
    return Order(
      id: id ?? this.id,
      total: total ?? this.total,
      products: products ?? this.products,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'total': total,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(
      id: map['id'],
      total: map['total'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, total: $total, products: $products, date: $date)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Order &&
        o.id == id &&
        o.total == total &&
        listEquals(o.products, products) &&
        o.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ total.hashCode ^ products.hashCode ^ date.hashCode;
  }
}
