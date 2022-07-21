import 'dart:convert';

class Order {
  Order({
    required this.customerOrder,
  });

  List<CustomerOrder>? customerOrder;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    customerOrder: json["orders"] == null ? null : List<CustomerOrder>.from(json["orders"].map((x) => CustomerOrder.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "orders": customerOrder == null ? null : List<dynamic>.from(customerOrder!.map((x) => x.toJson())),
  };
}

class CustomerOrder {
  CustomerOrder({
    required this.id,
    required this.companyId,
    required this.orderNumber,
    required this.createdAt,
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.phone,
    required this.country,
    required this.state,
    required this.isPaid,
    required this.subTotal,
    required this.shipping,
    required this.total,
    required this.discount,
    required this.orderState,
    required this.current,
  });

  int id;
  int companyId;
  String orderNumber;
  DateTime createdAt;
  int customerId;
  String firstName;
  String lastName;
  String address1;
  String address2;
  String phone;
  String country;
  String state;
  int isPaid;
  double subTotal;
  double shipping;
  double total;
  double discount;
  int orderState;
  DateTime current;

  factory CustomerOrder.fromJson(String str) => CustomerOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());


  factory CustomerOrder.fromMap(Map<String, dynamic> json) => CustomerOrder(
    id: json["id"] == null ? -1 : json["id"],
    companyId: json["company_id"] == null ? -1 : json["company_id"],
    orderNumber: json["order_number"] == null ? "null" : json["order_number"],
    createdAt: DateTime.parse(json["created_at"]),
    customerId: json["customer_id"] == null ? -1 : json["customer_id"],
    firstName: json["first_name"] == null ? "null" : json["first_name"],
    lastName: json["last_name"] == null ? "null" : json["last_name"],
    address1: json["address_1"] == null ? "null" : json["address_1"],
    address2: json["address_2"] == null ? "null" : json["address_2"],
    phone: json["phone"] == null ? "null" : json["phone"],
    country: json["country"] == null ? "null" : json["country"],
    state: json["state"] == null ? "null" : json["state"],
    isPaid: json["is_paid"]==null? 0 : json["is_paid"],
    subTotal: double.parse(json["sub_total"]),
    shipping: double.parse(json["shipping"]),
    total: double.parse(json["total"]),
    discount: double.parse(json["discount"]),
    orderState: json["order_state"] == null ? -1 : json["order_state"],
    current: DateTime.parse(json["current"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "company_id": companyId,
    "order_number": orderNumber,
    "created_at":  createdAt.toIso8601String(),
    "customer_id": customerId,
    "first_name": firstName,
    "last_name": lastName,
    "address_1": address1,
    "address_2": address2,
    "phone": phone,
    "country": country,
    "state": state,
    "is_paid": isPaid,
    "sub_total": subTotal,
    "shipping": shipping,
    "total": total,
    "discount": discount,
    "order_state": orderState,
    "current": current.toIso8601String(),
  };
}
