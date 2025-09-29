import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/profile/data/models/profile.dart';
import 'package:bayt_aura/features/profile/logic/profile.state.dart';
import 'package:bayt_aura/features/profile/data/repo/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit(this.repository) : super(const ProfileState.initial());

  Future<void> loadProfile() async {
    emit(const ProfileState.loading());
    try {
      final profile = await repository.getProfile();
      emit(ProfileState.loaded(profile));
    } catch (e) {
      emit(ProfileState.error(e.toString()));
    }
  }

  Future<void> updateProfile(Profile profile) async {
    emit(const ProfileState.loading());
    try {
      await repository.updateProfile(profile);
      final refreshed = await repository.getProfile();
      emit(ProfileState.loaded(refreshed));
    } catch (e) {
      emit(ProfileState.error(e.toString()));
    }
  }

  Future<void> deleteProfile() async {
    emit(const ProfileState.loading());
    try {
      await repository.deleteProfile();
      emit(const ProfileState.deleted());
    } catch (e) {
      emit(ProfileState.error(e.toString()));
    }
  }

  Future<void> uploadProfilePicture(File file) async {
    emit(const ProfileState.loading());
    try {
      await repository.uploadProfilePicture(file);
      final refreshed = await repository.getProfile();
      emit(ProfileState.loaded(refreshed));
    } catch (e) {
      emit(ProfileState.error(e.toString()));
    }
  }

  Future<void> deleteProfilePicture() async {
    emit(const ProfileState.loading());
    try {
      await repository.deleteProfilePicture();
      final refreshed = await repository.getProfile();
      emit(ProfileState.loaded(refreshed));
    } catch (e) {
      emit(ProfileState.error(e.toString()));
    }
  }
}
