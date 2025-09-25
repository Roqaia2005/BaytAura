import 'dart:io';
import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';

class MediaRepository {
  final ApiService _apiService;

  MediaRepository(this._apiService);

  Future<List<RequestImages>> fetchAllMedia(int propertyId) {
    return _apiService.getAllMedia(propertyId);
  }

  Future<RequestImages> fetchSingleMedia(int mediaId) {
    return _apiService.getSingleMedia(mediaId);
  }

  Future<RequestImages> uploadMedia(int propertyId, File file) async {
    final altName = file.path.split('/').last;
    return await _apiService.uploadMedia(propertyId, file, altName);
  }

  Future<void> deleteMedia(int propertyId, int mediaId) {
    return _apiService.deleteMedia(propertyId, mediaId);
  }
}
