import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/features/home/logic/property_state.dart';
import 'package:bayt_aura/features/home/data/models/property.dart';
import 'package:bayt_aura/features/home/data/property_repository.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit(this.propertyRepository)
    : super(PropertyLoaded(properties: const [], favorites: const []));
  final PropertyRepository propertyRepository;
  final List<Property> _allProperties = [];
  final List<Property> _favorites = [];
  final List<Property> _userProperties = [];

  void loadProperties(List<Property> properties) {
    _allProperties
      ..clear()
      ..addAll(properties);
    _emitLoaded();
  }

  void fetchProperties() {
    propertyRepository
        .fetchProperties()
        .then((fetchedProperties) {
          _allProperties
            ..clear()
            ..addAll(fetchedProperties);
          _emitLoaded();
        })
        .catchError((error) {
          emit(PropertyError(message: error.toString()));
        });
  }

  void addProperty(Property property) {
    propertyRepository
        .addProperty(property)
        .then((addedProperty) {
          _userProperties.add(addedProperty);
          _allProperties.add(addedProperty);
          _emitLoaded();
        })
        .catchError((error) {
          emit(PropertyError(message: error.toString()));
        });
  }

  void addFavorite(Property property) {
    propertyRepository
        .addFavorite(property.id)
        .then((_) {
          _favorites.add(property);
          _emitLoaded();
        })
        .catchError((error) {
          emit(PropertyError(message: error.toString()));
        });
  }

  void removeFavorite(Property property) {
    propertyRepository
        .removeFavorite(property.id)
        .then((_) {
          _favorites.removeWhere((fav) => fav.id == property.id);
          _emitLoaded();
        })
        .catchError((error) {
          emit(PropertyError(message: error.toString()));
        });
  }

  Future<void> toggleFavorite(Property property) async {
    if (_favorites.contains(property)) {
      removeFavorite(property);
    } else {
      addFavorite(property);
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
