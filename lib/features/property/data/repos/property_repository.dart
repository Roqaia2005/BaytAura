import 'package:dio/dio.dart';
import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/features/property/data/models/favorite.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';

class PropertyRepository {
  final ApiService _apiService;

  PropertyRepository({required ApiService apiService})
    : _apiService = apiService;

  Future<Property> addProperty(Property property) async {
    List<MultipartFile>? files;
    if (property.files != null) {
      files = property.files!
          .map((f) => MultipartFile.fromFileSync(f.path))
          .toList();
    }

    return _apiService.addProperty(
      property.title ?? "",
      property.type ?? "",
      property.purpose ?? "",
      property.description ?? "",
      property.price ?? 0,
      property.area ?? 0,
      property.address ?? "",
      property.latitude ?? 0,
      property.longitude ?? 0,

      files,
    );
  }

  Future<Property> fetchPropertyById(int id) async {
    try {
      final response = await _apiService.fetchPropertyById(id);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch property by ID: $e');
    }
  }

  Future<void> addFavorite(int propertyId) async {
    try {
      await _apiService.addFavorite(propertyId);
    } catch (e) {
      throw Exception('Failed to add favorite: $e');
    }
  }

  Future<void> removeFavorite(int favoriteId) async {
    try {
      await _apiService.removeFavorite(favoriteId);
    } catch (e) {
      throw Exception('Failed to remove favorite: $e');
    }
  }

  Future<List<Favorite>> fetchFavorites() async {
    try {
      final response = await _apiService.fetchMyFavorites();

      return response;
    } catch (e) {
      throw Exception('Failed to fetch favorites: $e');
    }
  }

  // DELETE property admin
  Future<void> deleteProperty(int propertyId) async {
    try {
      await _apiService.deleteProperty(propertyId);
    } catch (e) {
      throw Exception('Failed to delete property: $e');
    }
  }

  //provider,customer
  Future<void> deleteMyProperty(int propertyId) async {
    try {
      await _apiService.deleteMyProperty(propertyId);
    } catch (e) {
      throw Exception('Failed to delete property: $e');
    }
  }

  // UPDATE property **customer , provider only updates their properties
  Future<Property> updateProperty(Property property) async {
    return _apiService.updateMyProperty(
      property.id!, // path parameter
      {
        "title": property.title ?? "",
        "type": property.type ?? "",
        "purpose": property.purpose ?? "",
        "description": property.description ?? "",
        "price": property.price ?? 0,
        "area": property.area ?? 0,
        "address": property.address ?? "",
        "latitude": property.latitude ?? 0,
        "longitude": property.longitude ?? 0,
      },
    );
  }

  //customer,provider
  Future<List<Property>> getMyProperties() async {
    try {
      final response = await _apiService.getMyProperties();
      return response;
    } catch (e) {
      throw Exception('Failed to get properties: $e');
    }
  }

  Future<List<Property>> getProperties({
    String? query,
    String? type,
    int? minPrice,
    int? maxPrice,
    int? minArea,
    int? maxArea,
    String? owner,
    String? purpose,
    int page = 1,
    int size = 20,
  }) async {
    final response = await _apiService.getProperties(
      query: query,
      type: type,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minArea: minArea,
      maxArea: maxArea,
      owner: owner,
      purpose: purpose,
      page: page,
      size: size,
    );

    return response.data;
  }
}
