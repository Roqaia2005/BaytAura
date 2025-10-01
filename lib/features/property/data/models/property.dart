import 'dart:io';

class Property {
  int? id;
  String? title;
  String? type;
  String? purpose;
  String? description;
  double? price;
  double? area;
  String? address;
  double? latitude;
  double? longitude;
  List<Images>? images;
  List<File>? files;
  String? propertyStatus;
  String? createdAt;
  String? updatedAt;
  String? ownerName;
  bool? isFavorite;

  Property({
    this.id,
    this.title,
    this.type,
    this.purpose,
    this.description,
    this.price,
    this.area,
    this.address,
    this.latitude,
    this.longitude,
    this.images,
    this.propertyStatus,
    this.createdAt,
    this.updatedAt,
    this.ownerName,
    this.files,
  });

  Property.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    purpose = json['purpose'];
    description = json['description'];
    price = json['price'];
    area = json['area'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    propertyStatus = json['propertyStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    ownerName = json['ownerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['title'] = title;
    data['type'] = type;
    data['purpose'] = purpose;
    data['description'] = description;
    data['price'] = price;
    data['area'] = area;
    data['address'] = address;
    data['latitude'] = latitude;

    data['longitude'] = longitude;
    if (images != null) {
      data['media'] = images!.map((e) => e.url ?? "").toList();
    }

    return data;
  }

  Property copyWith({
    int? id,
    int? favoriteId,
    String? title,
    String? description,
  }) {
    return Property(
      id: id ?? this.id,

      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}

class Images {
  int? id;
  String? url;
  String? altName;
  String? publicId;

  Images({this.id, url, altName, publicId});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    altName = json['altName'];
    publicId = json['publicId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['altName'] = altName;
    data['publicId'] = publicId;
    return data;
  }
}
