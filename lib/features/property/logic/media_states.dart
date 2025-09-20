import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';


part 'media_states.freezed.dart';

@freezed
class MediaState with _$MediaState {
  const factory MediaState.initial() = _Initial;
  const factory MediaState.loading() = _Loading;
  const factory MediaState.loaded(List<RequestImages> media) = _Loaded;
  const factory MediaState.error(String message) = _Error;
  const factory MediaState.uploaded(RequestImages uploaded) = _Uploaded;
}
