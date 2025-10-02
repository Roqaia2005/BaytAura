import 'package:dio/dio.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';

class RecommendationService {
  final Dio _dio;

  RecommendationService(this._dio);

  Future<List<Property>> getLocationBasedRecommendations(
    int propertyId, {
    int limit = 5,
  }) async {
    final response = await _dio.get(
      "http://192.168.1.8:8000/api/recommendations/similar/location/$propertyId",
      queryParameters: {"limit": limit},
    );
    return (response.data as List)
        .map((json) => Property.fromRecommendationJson(json))
        .toList();
  }

  Future<List<Property>> getPriceBasedRecommendations(
    int propertyId, {
    int limit = 5,
  }) async {
    final response = await _dio.get(
      "http://192.168.1.8:8000/api/recommendations/similar/anywhere/$propertyId",
      queryParameters: {"limit": limit},
    );
    return (response.data as List)
        .map((json) => Property.fromRecommendationJson(json))
        .toList();
  }

  Future<List<Property>> getUserBasedRecommendations(
    int userId, {
    int limit = 5,
  }) async {
    final response = await _dio.get(
      "http://192.168.1.8:8000/api/recommendations/user/$userId",
      queryParameters: {"limit": limit},
    );
    return (response.data as List)
        .map((json) => Property.fromRecommendationJson(json))
        .toList();
  }
}
