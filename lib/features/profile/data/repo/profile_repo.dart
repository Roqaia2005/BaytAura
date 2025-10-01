import 'dart:io';
import 'package:dio/dio.dart';
import '../models/profile.dart';
import 'package:bayt_aura/core/networking/api_service.dart';

class ProfileRepository {
  final ApiService _api;

  ProfileRepository(this._api);

  Future<Profile> getProfile() => _api.getProfile();
  Future<Profile> updateProfile(Profile profile) {
    final body = {
      'username': profile.username,
      'firstName': profile.firstName,
      'lastName': profile.lastName,
      'phone': profile.phone,
      if (profile.companyName != null) 'companyName': profile.companyName!,
      if (profile.companyAddress != null)
        'companyAddress': profile.companyAddress!,
    };

    return _api.updateProfile(body);
  }

  Future<void> deleteProfile() async {
    await _api.deleteProfile().catchError((e) {});
  }

  Future<void> uploadProfilePicture(File file) async {
    final multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: file.uri.pathSegments.last,
    );
    await _api.uploadProfilePicture(multipartFile);
  }

  Future<void> deleteProfilePicture() => _api.deleteProfilePicture();
}
