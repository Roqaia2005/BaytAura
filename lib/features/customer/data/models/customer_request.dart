import 'dart:io';

class CustomerRequest {
  String title;
  String type;
  String purpose;
  String description;
  double price;
  double area;
  String address;
  double latitude;
  double longitude;

  int? id;
  List<RequestImages>? images;
  List<File>? files;
  String? status;
  String? customerName;

  CustomerRequest({
    required this.title,
    required this.type,
    required this.purpose,
    required this.description,
    required this.price,
    required this.area,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.id,
    this.images,
    this.status,
    this.customerName,
    this.files,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "type": type,
      "purpose": purpose,
      "description": description,
      "price": price,
      "area": area,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,


    };
  }

  factory CustomerRequest.fromJson(Map<String, dynamic> json) {
    return CustomerRequest(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      purpose: json['purpose'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      area: (json['area'] as num).toDouble(),
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      images: json['images'] != null
          ? (json['images'] as List)
                .map((e) => RequestImages.fromJson(e))
                .toList()
          : [],
      status: json['status'],
      customerName: json['customerName'],
    );
  }
}

class RequestImages {
  int? id;
  String? url;
  String? altName;
  String? publicId;

  RequestImages({this.id, this.url, this.altName, this.publicId});

  factory RequestImages.fromJson(Map<String, dynamic> json) {
    return RequestImages(
      id: json['id'],
      url: json['url'],
      altName: json['altName'],
      publicId: json['publicId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "url": url, "altName": altName, "publicId": publicId};
  }
}
