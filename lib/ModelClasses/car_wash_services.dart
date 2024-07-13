// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Services {
  int serviceId;
  String adminId;
  String serviceName;
  String description;
  String iconUrl;
  bool? isFavourite;
  List<Car> cars;
  String imageUrl;
  List<DateTime> availableDates;
  String adminPhoneNo;

  Services({
    required this.serviceId,
    required this.adminId,
    required this.serviceName,
    required this.description,
    required this.iconUrl,
    required this.isFavourite,
    required this.cars,
    required this.imageUrl,
    required this.availableDates,
    required this.adminPhoneNo,
  });

  Services copyWith({
    int? serviceId,
    String? adminId,
    String? serviceName,
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
      serviceName: serviceName ?? this.serviceName,
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
      'serviceName': serviceName,
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
      serviceId: map['serviceId'] as int,
      adminId: map['adminId'] as String,
      serviceName: map['serviceName'] as String,
      description: map['description'] as String,
      iconUrl: map['iconUrl'] as String,
      isFavourite:
          map['isFavourite'] != null ? map['isFavourite'] as bool : null,
      cars: List<Car>.from(
        (map['cars']).map<Car>(
          (x) => Car.fromMap(x as Map<String, dynamic>),
        ),
      ),
      imageUrl: map['imageUrl'] as String,
      availableDates: List<DateTime>.from(
        (map['availableDates']).map<DateTime>(
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
    return 'Services(serviceId: $serviceId, adminId: $adminId, serviceName: $serviceName, description: $description, iconUrl: $iconUrl, isFavourite: $isFavourite, cars: $cars, imageUrl: $imageUrl, availableDates: $availableDates, adminPhoneNo: $adminPhoneNo)';
  }

  @override
  bool operator ==(covariant Services other) {
    if (identical(this, other)) return true;

    return other.serviceId == serviceId &&
        other.adminId == adminId &&
        other.serviceName == serviceName &&
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
        serviceName.hashCode ^
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
  bool isAsset;
  Car({
    required this.carName,
    required this.price,
    required this.url,
    required this.isAsset,
  });

  Car copyWith({
    String? carName,
    String? price,
    String? url,
    bool? isAsset,
  }) {
    return Car(
      carName: carName ?? this.carName,
      price: price ?? this.price,
      url: url ?? this.url,
      isAsset: isAsset ?? this.isAsset,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'carName': carName,
      'price': price,
      'url': url,
      'isAsset': isAsset,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      carName: map['carName'] as String,
      price: map['price'] as String,
      url: map['url'] as String,
      isAsset: map['isAsset'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) =>
      Car.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Car(carName: $carName, price: $price, url: $url, isAsset: $isAsset)';
  }

  @override
  bool operator ==(covariant Car other) {
    if (identical(this, other)) return true;

    return other.carName == carName &&
        other.price == price &&
        other.url == url &&
        other.isAsset == isAsset;
  }

  @override
  int get hashCode {
    return carName.hashCode ^ price.hashCode ^ url.hashCode ^ isAsset.hashCode;
  }
}
