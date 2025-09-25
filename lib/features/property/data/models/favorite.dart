import 'package:bayt_aura/features/property/data/models/property.dart';

class Favorite {
  final int favoriteId;
  final Property property;

  Favorite({required this.favoriteId, required this.property});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      favoriteId: json['favoriteId'],
      property: Property.fromJson(json['property']),
    );
  }
}
