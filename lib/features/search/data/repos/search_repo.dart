import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';

class SearchRepo {
  final ApiService _apiService;

  SearchRepo({required ApiService apiService}) : _apiService = apiService;

  Future<List<Property>> search(String query) async {
    final results = await _apiService.searchProperties(query);

    return results;
  }

  Future<List<Property>> applyFilter({
    String? type,
    int? minPrice,
    int? maxPrice,
    int? rooms,
    int? minArea,
  }) async {
    final results = await _apiService.filterProperties(
      type: type,
      minPrice: minPrice,
      maxPrice: maxPrice,
      rooms: rooms,
      minArea: minArea,
    );
    return results;
  }
}
