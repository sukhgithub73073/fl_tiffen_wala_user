part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();
}

class GetMessageEvent extends MessageEvent {
  final Map<String, dynamic> map;

  const GetMessageEvent({required this.map});

  @override
  List<Object?> get props => [map];
}

class SendMessageEvent extends MessageEvent {
  final MessageModel messageModel;

  const SendMessageEvent({required this.messageModel});

  @override
  List<Object?> get props => [messageModel];
}
