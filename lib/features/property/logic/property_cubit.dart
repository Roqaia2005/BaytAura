import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/property/data/models/favorite.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/property/data/repos/media_repo.dart';
import 'package:bayt_aura/features/property/data/repos/property_repository.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit(this.propertyRepository, this.mediaRepo)
    : super(const PropertyState.initial());

  final PropertyRepository propertyRepository;
  final MediaRepository mediaRepo;

  final List<Property> _allProperties = [];
  final List<Property> _userProperties = [];
  final List<Favorite> _favorites = [];

  // Fetch all properties
  int currentPage = 1;

  Future<void> loadProperties({
    bool withFavorites = false,
    String? query,
    String? type,
    int? minPrice,
    int? maxPrice,
    int? minArea,
    int? maxArea,
    String? owner,
    String? purpose,
    int page = 1,
    int limit = 20,
  }) async {
    if (page == 1) {
      currentPage = 1;
      emit(const PropertyState.loading());
    }

    try {
      final fetchedProperties = await propertyRepository.getProperties(
        query: query,
        type: type,
        minPrice: minPrice,
        maxPrice: maxPrice,
        minArea: minArea,
        maxArea: maxArea,
        owner: owner,
        purpose: purpose,
        page: page,
        size: limit,
      );

      if (page == 1) {
        _allProperties
          ..clear()
          ..addAll(fetchedProperties);
      } else {
        _allProperties.addAll(fetchedProperties);
      }

      currentPage = page;

      emit(
        PropertyLoaded(
          properties: List.from(_allProperties),
          favorites: List.from(_favorites),
        ),
      );
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  // Fetch my properties (customer/provider)

  Future<void> fetchMyProperties() async {
    emit(const PropertyState.loading());
    try {
      final fetchedMyProperties = await propertyRepository.getMyProperties();
      _userProperties
        ..clear()
        ..addAll(fetchedMyProperties);

      emit(
        MyPropertyLoaded(
          myProperties: List.from(_userProperties),
          favorites: List.from(_favorites),
        ),
      );
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  // Add new property

  Future<void> addProperty(Property property, List<String>? imagePaths) async {
    emit(const PropertyState.loading());
    try {
      final addedProperty = await propertyRepository.addProperty(property);

      _userProperties.add(addedProperty);
      _allProperties.add(addedProperty);

      emit(PropertyAdded(property: addedProperty));
      // refresh my properties
      emit(
        MyPropertyLoaded(
          myProperties: List.from(_userProperties),
          favorites: List.from(_favorites),
        ),
      );
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  // Favorites

  Future<void> fetchFavorites() async {
    try {
      emit(PropertyState.loading());
      final fetchedFavorites = await propertyRepository.fetchFavorites();
      _updateFavorites(fetchedFavorites);

      emit(
        PropertyLoaded(
          properties: List.from(_allProperties),
          favorites: List.from(_favorites),
        ),
      );
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  Future<void> addFavorite(Property property) async {
    try {
      await propertyRepository.addFavorite(property.id!);
      final fetchedFavorites = await propertyRepository.fetchFavorites();
      _updateFavorites(fetchedFavorites);

      emit(
        PropertyLoaded(
          properties: List.from(_allProperties),
          favorites: List.from(_favorites),
        ),
      );
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  Future<void> removeFavorite(Favorite favorite) async {
    try {
      await propertyRepository.removeFavorite(favorite.favoriteId);
      final fetchedFavorites = await propertyRepository.fetchFavorites();
      _updateFavorites(fetchedFavorites);

      emit(
        PropertyLoaded(
          properties: List.from(_allProperties),
          favorites: List.from(_favorites),
        ),
      );
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

  Future<void> updateProperty(
    Property property,
    List<String>? imagePaths,
  ) async {
    emit(const PropertyState.loading());
    try {
      final updatedProperty = await propertyRepository.updateProperty(property);

      final index = _allProperties.indexWhere(
        (p) => p.id == updatedProperty.id,
      );
      if (index != -1) {
        _allProperties[index] = updatedProperty;
      }

      final userIndex = _userProperties.indexWhere(
        (p) => p.id == updatedProperty.id,
      );
      if (userIndex != -1) {
        _userProperties[userIndex] = updatedProperty;
      }

      List<String> uploadErrors = [];
      if (imagePaths != null) {
        for (final path in imagePaths) {
          final file = File(path);
          if (!file.existsSync()) continue;
          try {
            if (updatedProperty.id != null) {
              await mediaRepo.uploadMedia(updatedProperty.id!, file);
            }
          } catch (e) {
            uploadErrors.add(file.path);
          }
        }
      }

      emit(PropertyUpdated(property: updatedProperty));

      emit(
        PropertyLoaded(
          properties: List.from(_allProperties),
          favorites: List.from(_favorites),
        ),
      );

      emit(
        MyPropertyLoaded(
          myProperties: List.from(_userProperties),
          favorites: List.from(_favorites),
        ),
      );
    } catch (e) {
      emit(PropertyError(message: e.toString()));
    }
  }

  // ------------------------------
  // Delete property
  // ------------------------------
  Future<void> deleteProperty(int propertyId) async {
    try {
      await propertyRepository.deleteProperty(propertyId);

      _allProperties.removeWhere((p) => p.id == propertyId);
      _userProperties.removeWhere((p) => p.id == propertyId);
      _favorites.removeWhere((f) => f.property.id == propertyId);

      emit(PropertyDeleted(propertyId: propertyId));
      emit(
        PropertyLoaded(
          properties: List.from(_allProperties),
          favorites: List.from(_favorites),
        ),
      );
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }

  Future<void> deleteMyProperty(int propertyId) async {
    try {
      await propertyRepository.deleteMyProperty(propertyId);

      _allProperties.removeWhere((p) => p.id == propertyId);
      _userProperties.removeWhere((p) => p.id == propertyId);
      _favorites.removeWhere((f) => f.property.id == propertyId);

      emit(PropertyDeleted(propertyId: propertyId));
      emit(
        MyPropertyLoaded(
          myProperties: List.from(_userProperties),
          favorites: List.from(_favorites),
        ),
      );
    } catch (error) {
      emit(PropertyError(message: error.toString()));
    }
  }
}
