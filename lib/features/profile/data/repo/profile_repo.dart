import 'dart:io';
import '../models/profile.dart';
import 'package:bayt_aura/core/networking/api_service.dart';

class ProfileRepository {
  final ApiService _api;

  ProfileRepository(this._api);

  Future<Profile> getProfile() => _api.getProfile();
  Future<void> updateProfile(Profile profile) => _api.updateProfile(profile);
  Future<void> deleteProfile() => _api.deleteProfile();
  Future<void> uploadProfilePicture(File file) =>
      _api.uploadProfilePicture(file);
  Future<void> deleteProfilePicture() => _api.deleteProfilePicture();
}
