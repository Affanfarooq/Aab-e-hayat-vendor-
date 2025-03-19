
class Customer {
  final String customerId;
  final String name;
  final String phone;
  final String email;
  final String password;
  final SelectedItems selectedItems;
  final Address address;
  final DeliveryOptions deliveryOptions;
  final String registeredShopId;
  final String status;
  final DateTime createdAt;

  Customer({
    required this.customerId,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.selectedItems,
    required this.address,
    required this.deliveryOptions,
    required this.registeredShopId,
    required this.status,
    required this.createdAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json["customerId"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      password: json["password"],
      selectedItems: SelectedItems.fromJson(json["selectedItems"]),
      address: Address.fromJson(json["address"]),
      deliveryOptions: DeliveryOptions.fromJson(json["deliveryOptions"]),
      registeredShopId: json["registeredShopId"],
      status: json["status"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "customerId": customerId,
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
      "selectedItems": selectedItems.toJson(),
      "address": address.toJson(),
      "deliveryOptions": deliveryOptions.toJson(),
      "registeredShopId": registeredShopId,
      "status": status,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}

class SelectedItems {
  final int bottleQuantity;
  final int gallonQuantity;

  SelectedItems({required this.bottleQuantity, required this.gallonQuantity});

  factory SelectedItems.fromJson(Map<String, dynamic> json) {
    return SelectedItems(
      bottleQuantity: json["bottleQuantity"],
      gallonQuantity: json["gallonQuantity"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "bottleQuantity": bottleQuantity,
      "gallonQuantity": gallonQuantity,
    };
  }
}

class Address {
  final HomeLocation homeLocation;
  final String houseNumber;
  final String street;
  final String area;
  final String city;
  final String postalCode;
  final String landmark;

  Address({
    required this.homeLocation,
    required this.houseNumber,
    required this.street,
    required this.area,
    required this.city,
    required this.postalCode,
    required this.landmark,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      homeLocation: HomeLocation.fromJson(json["homeLocation"]),
      houseNumber: json["houseNumber"],
      street: json["street"],
      area: json["area"],
      city: json["city"],
      postalCode: json["postalCode"],
      landmark: json["landmark"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "homeLocation": homeLocation.toJson(),
      "houseNumber": houseNumber,
      "street": street,
      "area": area,
      "city": city,
      "postalCode": postalCode,
      "landmark": landmark,
    };
  }
}

class HomeLocation {
  final double latitude;
  final double longitude;

  HomeLocation({required this.latitude, required this.longitude});

  factory HomeLocation.fromJson(Map<String, dynamic> json) {
    return HomeLocation(
      latitude: json["latitude"].toDouble(),
      longitude: json["longitude"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}

class DeliveryOptions {
  final String selectedSchedule;
  final String selectedTimeSlot;

  DeliveryOptions({required this.selectedSchedule, required this.selectedTimeSlot});

  factory DeliveryOptions.fromJson(Map<String, dynamic> json) {
    return DeliveryOptions(
      selectedSchedule: json["selectedSchedule"],
      selectedTimeSlot: json["selectedTimeSlot"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "selectedSchedule": selectedSchedule,
      "selectedTimeSlot": selectedTimeSlot,
    };
  }
}