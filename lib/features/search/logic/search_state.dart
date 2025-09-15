import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bayt_aura/features/home/data/models/property.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.loaded(List<Property> results) = _Loaded;
  const factory SearchState.error(String message) = _Error;
}
