// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Services {
  String serviceId;
  String adminId;
  String name;
  String description;
  String iconUrl;
  bool isFavourite;
  List<Car> cars;
  String imageUrl;
  List<DateTime> availableDates;
  String adminPhoneNo;
  Services({
    required this.serviceId,
    required this.adminId,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.isFavourite,
    required this.cars,
    required this.imageUrl,
    required this.availableDates,
    required this.adminPhoneNo,
  });

  Services copyWith({
    String? serviceId,
    String? adminId,
    String? name,
    String? description,
    String? iconUrl,
    bool? isFavourite,
    List<Car>? cars,
    String? imageUrl,
    List<DateTime>? availableDates,
    String? adminPhoneNo,
  }) {
    return Services(
      serviceId: serviceId ?? this.serviceId,
      adminId: adminId ?? this.adminId,
      name: name ?? this.name,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      isFavourite: isFavourite ?? this.isFavourite,
      cars: cars ?? this.cars,
      imageUrl: imageUrl ?? this.imageUrl,
      availableDates: availableDates ?? this.availableDates,
      adminPhoneNo: adminPhoneNo ?? this.adminPhoneNo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceId': serviceId,
      'adminId': adminId,
      'name': name,
      'description': description,
      'iconUrl': iconUrl,
      'isFavourite': isFavourite,
      'cars': cars.map((x) => x.toMap()).toList(),
      'imageUrl': imageUrl,
      'availableDates':
          availableDates.map((x) => x.millisecondsSinceEpoch).toList(),
      'adminPhoneNo': adminPhoneNo,
    };
  }

  factory Services.fromMap(Map<String, dynamic> map) {
    return Services(
      serviceId: map['serviceId'] as String,
      adminId: map['adminId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      iconUrl: map['iconUrl'] as String,
      isFavourite: map['isFavourite'] as bool,
      cars: List<Car>.from(
        (map['cars'] as List<int>).map<Car>(
          (x) => Car.fromMap(x as Map<String, dynamic>),
        ),
      ),
      imageUrl: map['imageUrl'] as String,
      availableDates: List<DateTime>.from(
        (map['availableDates'] as List<int>).map<DateTime>(
          (x) => DateTime.fromMillisecondsSinceEpoch(x),
        ),
      ),
      adminPhoneNo: map['adminPhoneNo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Services.fromJson(String source) =>
      Services.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Services(serviceId: $serviceId, adminId: $adminId, name: $name, description: $description, iconUrl: $iconUrl, isFavourite: $isFavourite, cars: $cars, imageUrl: $imageUrl, availableDates: $availableDates, adminPhoneNo: $adminPhoneNo)';
  }

  @override
  bool operator ==(covariant Services other) {
    if (identical(this, other)) return true;

    return other.serviceId == serviceId &&
        other.adminId == adminId &&
        other.name == name &&
        other.description == description &&
        other.iconUrl == iconUrl &&
        other.isFavourite == isFavourite &&
        listEquals(other.cars, cars) &&
        other.imageUrl == imageUrl &&
        listEquals(other.availableDates, availableDates) &&
        other.adminPhoneNo == adminPhoneNo;
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
        adminId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        iconUrl.hashCode ^
        isFavourite.hashCode ^
        cars.hashCode ^
        imageUrl.hashCode ^
        availableDates.hashCode ^
        adminPhoneNo.hashCode;
  }
}

class Car {
  String carName;
  String price;
  String url;
  Car({
    required this.carName,
    required this.price,
    required this.url,
  });

  Car copyWith({
    String? carName,
    String? price,
    String? url,
  }) {
    return Car(
      carName: carName ?? this.carName,
      price: price ?? this.price,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'carName': carName,
      'price': price,
      'url': url,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      carName: map['carName'] as String,
      price: map['price'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) =>
      Car.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Car(carName: $carName, price: $price, url: $url)';

  @override
  bool operator ==(covariant Car other) {
    if (identical(this, other)) return true;

    return other.carName == carName && other.price == price && other.url == url;
  }

  @override
  int get hashCode => carName.hashCode ^ price.hashCode ^ url.hashCode;
}
