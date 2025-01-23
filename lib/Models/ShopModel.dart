class Shop {
  final String shopId;
  final String? ownerName;
  final String? shopName;
  final String? shopDescription;
  final String? shopEmail;
  final int? shopPhone;
  final String? shopImage;
  final Map<String, dynamic>? shopLocation;
  final List<String>? deliveryOptions;
  final List<Map<String, String>>? deliveryTimes; 
  final Map<String, String>? ownerCnic;
  final bool? accountApprove;
  final bool? isCertified;
  final int? totalGalons;
  final int? totalBottles;

  Shop({
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
    this.totalGalons,
    this.totalBottles,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopId: json['shopId'] ?? "",
      ownerName: json['ownerName'] ?? "",
      shopName: json['shopName'] ?? "",
      shopDescription: json['shopDescription'] ?? "",
      shopEmail: json['shopEmail'] ?? "",
      shopPhone: json['shopPhone'] ?? 0,
      shopImage: json['shopImage'] ?? "",
      shopLocation: json['shopLocation'] != null
          ? {
              'shopAddress': json['shopAddress'],
              'latitude': json['latitude'],
              'longitude': json['longitude'],
            }
          : null,
      deliveryOptions: json['deliveryOptions'] != null
          ? List<String>.from(json['deliveryOptions'])
          : null,
      deliveryTimes: json['deliveryTimes'] != null
          ? List<Map<String, String>>.from(json['deliveryTimes'].map((time) => {
                'start': time['start'],
                'end': time['end'],
              }))
          : null,
      ownerCnic: json['ownerCnic'] != null
          ? {
              'cnicFront': json['ownerCnic']['cnicFront'],
              'cnicBack': json['ownerCnic']['cnicBack'],
            }
          : null,
      accountApprove: json['accountApprove'] ?? false,
      isCertified: json['isCertified'] ?? false,
      totalGalons: json['totalGalons'] ?? 0,
      totalBottles: json['totalBottles'] ?? 0,
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
      'shopLocation': shopLocation != null
          ? {
              'shopAddress': shopLocation!['shopAddress'],
              'latitude': shopLocation!['latitude'],
              'longitude': shopLocation!['longitude'],
            }
          : null,
      'deliveryOptions': deliveryOptions,
      'deliveryTimes': deliveryTimes?.map((time) => {
                'start': time['start'],
                'end': time['end'],
              }).toList(),
      'ownerCnic': ownerCnic != null
          ? {
              'cnicFront': ownerCnic!['cnicFront'],
              'cnicBack': ownerCnic!['cnicBack'],
            }
          : null,
      'accountApprove': accountApprove,
      'isCertified': isCertified,
      'totalGalons': totalGalons,
      'totalBottles': totalBottles,
    };
  }
}
