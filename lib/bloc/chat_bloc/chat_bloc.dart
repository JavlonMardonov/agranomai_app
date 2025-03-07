import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:agranom_ai/data/repositories/chat_repo.dart';

part 'chat_bloc.freezed.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.sendMessage(String message, String id) = _SendMessage;
}

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = _Initial;
  const factory ChatState.loading() = _Loading;
  const factory ChatState.success(String message) = _Success;
  const factory ChatState.error(String message) = _Error;
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;

  ChatBloc({required ChatRepository chatRepository})
      : _chatRepository = chatRepository,
        super(const ChatState.initial()) {
    on<ChatEvent>((event, emit) async {
      await event.when(
        sendMessage: (message, id) => _onSendMessage(message, id, emit),
      );
    });
  }

  Future<void> _onSendMessage(
      String message, String id, Emitter<ChatState> emit) async {
    try {
      emit(const ChatState.loading());
      final response = await _chatRepository.getChat(message: message, id: id);

      if (response != null) {
        emit(ChatState.success(response));
      } else {
        emit(const ChatState.error('No response received'));
      }
    } catch (e) {
      emit(ChatState.error(e.toString()));
    }
  }
}
