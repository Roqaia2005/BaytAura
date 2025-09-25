import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/property/data/models/favorite.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/property/data/repos/media_repo.dart';
import 'package:bayt_aura/features/property/data/repos/property_repository.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit(this.propertyRepository, this.mediaRepo)
    : super(PropertyLoaded(properties: const [], favorites: const []));

  final PropertyRepository propertyRepository;
  final MediaRepository mediaRepo;

  final List<Property> _allProperties = [];
  final List<Property> myProperties = [];
  final List<Favorite> _favorites = [];
  final List<Property> _userProperties = [];

  void loadProperties(List<Property> properties) {
    _allProperties
      ..clear()
      ..addAll(properties);
    _emitLoaded();
  }

  //for customer and provider

  void fetchPropertiesWithFavorites() async {
    try {
      final fetchedProperties = await propertyRepository.fetchProperties();
      _allProperties
        ..clear()
        ..addAll(fetchedProperties);

      final fetchedFavorites = await propertyRepository.fetchFavorites();
      _updateFavorites(fetchedFavorites);

      _emitLoaded();
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  void fetchProperties() async {
    try {
      final fetchedProperties = await propertyRepository.fetchProperties();
      _allProperties
        ..clear()
        ..addAll(fetchedProperties);

      _emitLoaded();
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  //customer,provider
  void fetchMyProperties() async {
    emit(const PropertyState.loading());
    try {
      final fetchedMyProperties = await propertyRepository.getMyProperties();
      _userProperties
        ..clear()
        ..addAll(fetchedMyProperties);
      emit(
        PropertyLoaded(
          properties: List.from(_userProperties),
          favorites: List.from(_favorites),
        ),
      );
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  void fetchFavorites() async {
    try {
      final fetchedFavorites = await propertyRepository.fetchFavorites();
      _updateFavorites(fetchedFavorites);
      _emitLoaded();
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  void addProperty(Property property, List<String>? imagePaths) async {
    emit(PropertyState.loading());
    try {
      final addedProperty = await propertyRepository.addProperty(property);

      _userProperties.add(addedProperty);
      _allProperties.add(addedProperty);

      List<String> uploadErrors = [];
      if (imagePaths != null) {
        for (final path in imagePaths) {
          final file = File(path);
          if (!file.existsSync()) continue;
          try {
            if (addedProperty.id != null) {
              await mediaRepo.uploadMedia(addedProperty.id!, file);
            }
          } catch (e) {
            uploadErrors.add(file.path);
          }
        }
      }

      emit(PropertyAdded(property: addedProperty, uploadErrors: uploadErrors));
    } catch (error) {
      emit(PropertyState.error(message: error.toString()));
    }
  }

  void addFavorite(Property property) async {
    try {
      await propertyRepository.addFavorite(property.id!);
      final fetchedFavorites = await propertyRepository.fetchFavorites();
      _updateFavorites(fetchedFavorites);
      _emitLoaded();
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  Future<void> removeFavorite(Favorite favorite) async {
    try {
      await propertyRepository.removeFavorite(favorite.favoriteId);
      final fetchedFavorites = await propertyRepository.fetchFavorites();
      _updateFavorites(fetchedFavorites);
      _emitLoaded();
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  void _updateFavorites(List<Favorite> fetchedFavorites) {
    _favorites
      ..clear()
      ..addAll(fetchedFavorites);

    for (var i = 0; i < _allProperties.length; i++) {
      final match = _favorites.where(
        (fav) => fav.property.id == _allProperties[i].id,
      );

      _allProperties[i] = _allProperties[i].copyWith(
        favoriteId: match.isNotEmpty ? match.first.favoriteId : null,
      );
    }
  }

  Future<void> deleteProperty(int propertyId) async {
    try {
      await propertyRepository.deleteProperty(propertyId);
      emit(PropertyDeleted(propertyId: propertyId));

      _allProperties.removeWhere((p) => p.id == propertyId);
      _userProperties.removeWhere((p) => p.id == propertyId);
      _favorites.removeWhere((f) => f.property.id == propertyId);

      _emitLoaded();
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  Future<void> deleteMyProperty(int propertyId) async {
    try {
      await propertyRepository.deleteMyProperty(propertyId);
      emit(PropertyDeleted(propertyId: propertyId));

      _allProperties.removeWhere((p) => p.id == propertyId);
      _userProperties.removeWhere((p) => p.id == propertyId);
      _favorites.removeWhere((f) => f.property.id == propertyId);

      _emitLoaded();
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  Future<void> updateProperty(Property property) async {
    emit(const PropertyState.loading());
    try {
      final updatedProperty = await propertyRepository.updateProperty(property);

      // Update _allProperties
      final index = _allProperties.indexWhere(
        (p) => p.id == updatedProperty.id,
      );
      if (index != -1) _allProperties[index] = updatedProperty;

      // Update _userProperties if exists
      final userIndex = _userProperties.indexWhere(
        (p) => p.id == updatedProperty.id,
      );
      if (userIndex != -1) _userProperties[userIndex] = updatedProperty;

      emit(PropertyUpdated(property: updatedProperty));
    } catch (e) {
      emit(PropertyError(message: e.toString()));
    }
  }

  void _emitLoaded() {
    emit(
      PropertyLoaded(
        properties: List.from(_allProperties),
        favorites: List.from(_favorites),
      ),
    );
  }
}
