import 'package:bayt_aura/features/property/data/models/property.dart';

class PropertiesResponse {
  final List<Property> data;

  PropertiesResponse({required this.data});

  factory PropertiesResponse.fromJson(Map<String, dynamic> json) {
    return PropertiesResponse(
      data: (json['data'] as List)
          .map((item) => Property.fromJson(item))
          .toList(),
    );
  }
}
