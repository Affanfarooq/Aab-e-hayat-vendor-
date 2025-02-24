class ShopModel {
  final String shopId;
  final String? ownerName;
  final String? shopName;
  final String? shopDescription;
  final String? shopEmail;
  final int? shopPhone;
  final String? shopImage;
  final ShopLocation? shopLocation;
  final List<String>? deliveryOptions;
  final List<DeliveryTime>? deliveryTimes;
  final OwnerCnic? ownerCnic;
  final bool? accountApprove;
  final bool? isCertified;
  final Bottles? bottles;
  final double? shopRating;

  ShopModel({
    required this.shopId,
    this.ownerName,
    this.shopName,
    this.shopDescription,
    this.shopEmail,
    this.shopPhone,
    this.shopImage,
    this.shopLocation,
    this.deliveryOptions,
    this.deliveryTimes,
    this.ownerCnic,
    this.accountApprove,
    this.isCertified,
    this.bottles,
    this.shopRating,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      shopId: json['shopId'] ?? "",
      ownerName: json['ownerName'] ?? "",
      shopName: json['shopName'] ?? "",
      shopDescription: json['shopDescription'] ?? "",
      shopEmail: json['shopEmail'] ?? "",
      shopPhone: json['shopPhone'] ?? 0,
      shopImage: json['shopImage'] ?? "",
      shopLocation: json['shopLocation'] != null
          ? ShopLocation.fromJson(json['shopLocation'])
          : null,
      deliveryOptions: json['deliveryOptions'] != null
          ? List<String>.from(json['deliveryOptions'])
          : null,
      deliveryTimes: json['deliveryTimes'] != null
          ? List<DeliveryTime>.from(json['deliveryTimes']
              .map((time) => DeliveryTime.fromJson(time)))
          : null,
      ownerCnic: json['ownerCnic'] != null
          ? OwnerCnic.fromJson(json['ownerCnic'])
          : null,
      accountApprove: json['accountApprove'] ?? false,
      isCertified: json['isCertified'] ?? false,
      bottles:
          json['bottles'] != null ? Bottles.fromJson(json['bottles']) : null,
      shopRating: json['shopRating']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shopId': shopId,
      'ownerName': ownerName,
      'shopName': shopName,
      'shopDescription': shopDescription,
      'shopEmail': shopEmail,
      'shopPhone': shopPhone,
      'shopImage': shopImage,
      'shopLocation': shopLocation?.toJson(),
      'deliveryOptions': deliveryOptions,
      'deliveryTimes': deliveryTimes?.map((time) => time.toJson()).toList(),
      'ownerCnic': ownerCnic?.toJson(),
      'accountApprove': accountApprove,
      'isCertified': isCertified,
      'bottles': bottles?.toJson(),
      'shopRating': shopRating,
    };
  }
}

/// **Shop Location Model**
class ShopLocation {
  final String? shopAddress;
  final double? latitude;
  final double? longitude;

  ShopLocation({this.shopAddress, this.latitude, this.longitude});

  factory ShopLocation.fromJson(Map<String, dynamic> json) {
    return ShopLocation(
      shopAddress: json['shopAddress'] ?? "",
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shopAddress': shopAddress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class DeliveryTime {
  final String? start;
  final String? end;

  DeliveryTime({this.start, this.end});

  factory DeliveryTime.fromJson(Map<String, dynamic> json) {
    return DeliveryTime(
      start: json['start'] ?? "",
      end: json['end'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
    };
  }
}

class OwnerCnic {
  final String? cnicFront;
  final String? cnicBack;

  OwnerCnic({this.cnicFront, this.cnicBack});

  factory OwnerCnic.fromJson(Map<String, dynamic> json) {
    return OwnerCnic(
      cnicFront: json['cnicFront'] ?? "",
      cnicBack: json['cnicBack'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cnicFront': cnicFront,
      'cnicBack': cnicBack,
    };
  }
}

/// **Bottles Model**
class Bottles {
  final int? totalGalons;
  final double? galonPrice;
  final int? totalBottles;
  final double? bottlePrice;

  Bottles({this.totalGalons, this.galonPrice, this.totalBottles, this.bottlePrice});

  factory Bottles.fromJson(Map<String, dynamic> json) {
    return Bottles(
      totalGalons: json['totalGalons'] ?? 0,
      galonPrice: json['galonPrice']?.toDouble() ?? 0.0,
      totalBottles: json['totalBottles'] ?? 0,
      bottlePrice: json['bottlePrice']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalGalons': totalGalons,
      'galonPrice': galonPrice,
      'totalBottles': totalBottles,
      'bottlePrice': bottlePrice,
    };
  }
}
