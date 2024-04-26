import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tiffen_wala_user/common/models/message_model.dart';
import 'package:tiffen_wala_user/common/utils/app_extension.dart';
import 'package:tiffen_wala_user/repositiries/chat_repo.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  var chatRepository = GetIt.I<ChatRepository>();

  MessageBloc() : super(MessageInitial()) {
    on<GetMessageEvent>(_getMessagesListApi);
    on<SendMessageEvent>(_sendMessagesListApi);
  }

  Future<FutureOr<void>> _getMessagesListApi(GetMessageEvent event, Emitter<MessageState> emit) async {
    try {
      emit(MessageLoading());
      var chatList = await chatRepository.getMessagesApi(event.map);
      "${chatList.length}".printLog(msg: "_getMessagesListApi>>>>>>>>>>>>>") ;
      emit(MessageSuccess(messagesList: chatList)) ;
    } catch (e,t) {
      emit(MessageError(error: "$e"));
      "${e} $t".printLog(msg: "_getMessagesListApi>>>>>>>>>>>>>Exeption") ;

    }



  }

  Future<FutureOr<void>> _sendMessagesListApi(SendMessageEvent event, Emitter<MessageState> emit) async {
    await chatRepository.sendMessage(event.messageModel) ;
  }
}
