// class CustomerRequest {
//   int? id;
//   String? title;
//   String? type;
//   String? purpose;
//   String? description;
//   double? price;
//   double? area;
//   String? address;
//   double? latitude;
//   double? longitude;
//   List<RequestImages>? images;
  
//   String? createdAt;
//   String? updatedAt;
//   String? customerName;
//   String? status;

//   CustomerRequest({
//     this.id,
//     this.title,
//     this.type,
//     this.purpose,
//     this.description,
//     this.price,
//     this.area,
//     this.address,
//     this.latitude,
//     this.longitude,
//     this.images,
   
//     this.createdAt,
//     this.updatedAt,
//     this.customerName,
//     this.status,
//   });

//   CustomerRequest.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     status = json['status'];
//     type = json['type'];
//     purpose = json['purpose'];
//     description = json['description'];
//     price = json['price'];
//     area = json['area'];
//     address = json['address'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     if (json['images'] != null) {
//       images = <RequestImages>[];
//       json['images'].forEach((v) {
//         images!.add(RequestImages.fromJson(v));
//       });
//     }
   
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     customerName = json['customerName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['type'] = type;
//     data['status'] = status;
//     data['purpose'] = purpose;
//     data['description'] = description;
//     data['price'] = price;
//     data['area'] = area;
//     data['address'] = address;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     if (images != null) {
//       data['images'] = images!.map((RequestImages v) => v.toJson()).toList();
//     }
  
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['customerName'] = customerName;
//     return data;
//   }
// }

// class RequestImages {
//   int? id;
//   String? url;
//   String? altName;
//   String? publicId;

//   RequestImages({id, url, altName, publicId});

//   RequestImages.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     url = json['url'];
//     altName = json['altName'];
//     publicId = json['publicId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['url'] = url;
//     data['altName'] = altName;
//     data['publicId'] = publicId;
//     return data;
//   }
// }
