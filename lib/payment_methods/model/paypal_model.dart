// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class PaypalItems {
//   String name;
//   int quantity;
//   String price;
//   String currency;
//   PaypalItems({
//     required this.name,
//     required this.quantity,
//     required this.price,
//     required this.currency,
//   });

//   PaypalItems copyWith({
//     String? name,
//     int? quantity,
//     String? price,
//     String? currency,
//   }) {
//     return PaypalItems(
//       name: name ?? this.name,
//       quantity: quantity ?? this.quantity,
//       price: price ?? this.price,
//       currency: currency ?? this.currency,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'quantity': quantity,
//       'price': price,
//       'currency': currency,
//     };
//   }

//   factory PaypalItems.fromMap(Map<String, dynamic> map) {
//     return PaypalItems(
//       name: map['name'] as String,
//       quantity: map['quantity'] as int,
//       price: map['price'] as String,
//       currency: map['currency'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory PaypalItems.fromJson(String source) =>
//       PaypalItems.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'PaypalItems(name: $name, quantity: $quantity, price: $price, currency: $currency)';
//   }

//   @override
//   bool operator ==(covariant PaypalItems other) {
//     if (identical(this, other)) return true;

//     return other.name == name &&
//         other.quantity == quantity &&
//         other.price == price &&
//         other.currency == currency;
//   }

//   @override
//   int get hashCode {
//     return name.hashCode ^
//         quantity.hashCode ^
//         price.hashCode ^
//         currency.hashCode;
//   }
// }
