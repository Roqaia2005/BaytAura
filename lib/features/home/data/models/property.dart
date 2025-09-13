class Property {
  final String title;
  final String type;
  final String description;
  final double price;
  final double area;
  final String address;
  final double latitude;
  final double longitude;

  Property({
    required this.title,
    required this.type,
    required this.description,
    required this.price,
    required this.area,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  // Convert Property → JSON (for API/Firebase)
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "type": type,
      "description": description,
      "price": price,
      "area": area,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  // Convert JSON → Property (for reading data)
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      title: json["title"],
      type: json["type"],
      description: json["description"],
      price: (json["price"] as num).toDouble(),
      area: (json["area"] as num).toDouble(),
      address: json["address"],
      latitude: (json["latitude"] as num).toDouble(),
      longitude: (json["longitude"] as num).toDouble(),
    );
  }
}
