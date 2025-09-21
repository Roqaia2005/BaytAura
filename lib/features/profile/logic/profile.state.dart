import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bayt_aura/features/profile/data/models/profile.dart';


  part 'profile.state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded(Profile profile) = _Loaded;
  const factory ProfileState.error(String message) = _Error;
}
