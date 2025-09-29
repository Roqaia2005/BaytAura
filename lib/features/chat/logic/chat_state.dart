import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bayt_aura/features/chat/model/chat_message.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = _Initial;

  const factory ChatState.loading(List<ChatMessage> messages) = _Loading;

  const factory ChatState.loaded(List<ChatMessage> messages) = _Loaded;

  const factory ChatState.error(String message, List<ChatMessage> messages) =
      _Error;
}
