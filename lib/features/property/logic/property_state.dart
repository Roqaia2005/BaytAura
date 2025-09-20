import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';



part 'property_state.freezed.dart';
@freezed
class PropertyState with _$PropertyState {
  /// Initial state
  const factory PropertyState.initial() = PropertyInitial;

  /// Loading state
  const factory PropertyState.loading() = PropertyLoading;

  /// Loaded state (with properties + favorites)
  const factory PropertyState.loaded({
    required List<Property> properties,
    required List<Property> favorites,
  }) = PropertyLoaded;

  /// Error state
  const factory PropertyState.error({
    required String message,
  }) = PropertyError;
}
