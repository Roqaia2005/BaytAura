import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bayt_aura/features/property/data/models/favorite.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';

part 'property_state.freezed.dart';

@freezed
class PropertyState with _$PropertyState {
  const factory PropertyState.initial() = PropertyInitial;

  const factory PropertyState.loading() = PropertyLoading;

  /// all properties (public)
  const factory PropertyState.loaded({
    required List<Property> properties,
    required List<Favorite> favorites,
  }) = PropertyLoaded;

  /// my properties (customer / provider)
  const factory PropertyState.myLoaded({
    required List<Property> myProperties,
    required List<Favorite> favorites,
  }) = MyPropertyLoaded;

  const factory PropertyState.error({required String message}) = PropertyError;

  const factory PropertyState.updated({required Property property}) =
      PropertyUpdated;

  const factory PropertyState.deleted({required int propertyId}) =
      PropertyDeleted;

  const factory PropertyState.added({
    required Property property,
    @Default([]) List<String> uploadErrors,
  }) = PropertyAdded;
}
