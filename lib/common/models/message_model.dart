class MessageModel {
  String message;
  String recieve_by;
  String send_by;
  String seen_status;
  String send_at;

  MessageModel(
      {required this.message,
      required this.recieve_by,
      required this.send_by,
      required this.seen_status,
      required this.send_at});
}
