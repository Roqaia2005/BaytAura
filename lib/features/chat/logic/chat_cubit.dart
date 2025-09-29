import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/networking/chat_service.dart';
import 'package:bayt_aura/features/chat/logic/chat_state.dart';
import 'package:bayt_aura/features/chat/model/chat_message.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatService chatService;

  ChatCubit(this.chatService) : super(const ChatState.initial());

  Future<void> sendMessage(String message) async {
    final List<ChatMessage> currentMessages = state.maybeWhen(
      loaded: (msgs) => msgs,
      loading: (msgs) => msgs,
      error: (_, msgs) => msgs,
      orElse: () => [],
    );

    final List<ChatMessage> updatedMessages = [
      ...currentMessages,
      ChatMessage(text: message, isUser: true),
    ];
    emit(ChatState.loading(updatedMessages));

    try {
      final response = await chatService.sendMessage({"query": message});

      emit(
        ChatState.loaded([
          ...updatedMessages,
          ChatMessage(text: response.answer, isUser: false),
        ]),
      );
    } catch (e) {
      emit(ChatState.error(e.toString(), updatedMessages));
    }
  }
}
