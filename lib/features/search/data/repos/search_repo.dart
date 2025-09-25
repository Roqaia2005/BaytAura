import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';

class SearchRepo {
  final ApiService _apiService;

  SearchRepo({required ApiService apiService}) : _apiService = apiService;

  Future<List<Property>> getProperties({
    String? query,
    String? type,
    int? minPrice,
    int? maxPrice,

    int? minArea,
    int? maxArea,
    String? owner,
    String? purpose,
  }) async {
    return await _apiService.getProperties(
      query: query,
      type: type,
      minPrice: minPrice,
      maxPrice: maxPrice,

      minArea: minArea,
      maxArea: maxArea,
      owner: owner,
      purpose: purpose,
    );
  }
}
