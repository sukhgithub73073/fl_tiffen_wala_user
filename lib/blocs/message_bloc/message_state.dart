part of 'message_bloc.dart';

sealed class MessageState extends Equatable {
  const MessageState();
}

final class MessageInitial extends MessageState {
  @override
  List<Object> get props => [];
}

final class MessageLoading extends MessageState {
  @override
  List<Object> get props => [];
}

final class MessageError extends MessageState {
  final String error;

  MessageError({required this.error});

  @override
  List<Object> get props => [error];
}

final class MessageSuccess extends MessageState {
  final List<MessageModel> messagesList;

  MessageSuccess({required this.messagesList});

  @override
  List<Object> get props => [messagesList];
}

final class MessageSendMessage extends MessageState {
  final MessageModel messageModel;

  MessageSendMessage({required this.messageModel});

  @override
  List<Object> get props => [messageModel];
}

final class MessageRecieveMessage extends MessageState {
  final MessageModel messageModel;

  MessageRecieveMessage({required this.messageModel});

  @override
  List<Object> get props => [messageModel];
}
