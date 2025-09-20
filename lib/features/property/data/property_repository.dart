import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/core/helpers/shared_pref_helper.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';

class PropertyRepository {
  final ApiService _apiService;

  PropertyRepository({required ApiService apiService})
    : _apiService = apiService;

  Future<Property> addProperty(Property property) async {
    try {
      final response = await _apiService.addProperty(property);
      return response;
    } catch (e) {
      throw Exception('Failed to add property: $e');
    }
  }

  Future<List<Property>> fetchProperties() async {
    try {
  final token = await SharedPrefHelper.getSecuredString("auth_token");
      final response = await _apiService.fetchProperties();
      return response;
    } catch (e) {
      throw Exception('Failed to fetch properties: $e');
    }
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

  Future<void> removeFavorite(int propertyId) async {
    try {
      await _apiService.removeFavorite(propertyId);
    } catch (e) {
      throw Exception('Failed to remove favorite: $e');
    }
  }
}
