import 'dart:io';
import 'package:dio/dio.dart';
import '../models/profile.dart';
import 'package:bayt_aura/core/networking/api_service.dart';

class ProfileRepository {
  final ApiService _api;

  ProfileRepository(this._api);

  Future<Profile> getProfile() => _api.getProfile();
  Future<void> updateProfile(Profile profile) => _api.updateProfile(profile);
  Future<void> deleteProfile() => _api.deleteProfile();
  Future<void> uploadProfilePicture(File file) async {
    final formData = FormData.fromMap({"file": file});

    await _api.uploadProfilePicture(formData);
  }

  Future<void> deleteProfilePicture() => _api.deleteProfilePicture();
}
