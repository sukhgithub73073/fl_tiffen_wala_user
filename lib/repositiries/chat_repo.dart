import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiffen_wala_user/common/firebaseprovider/firestore_table.dart';
import 'package:tiffen_wala_user/common/models/message_model.dart';
import 'package:tiffen_wala_user/common/utils/app_extension.dart';
import 'package:timeago/timeago.dart' as timeago;

abstract class ChatRepository {
  Future<List<MessageModel>> getMessagesApi(Map<String, dynamic> map);

  sendMessage(MessageModel messageModel);
}

class ChatRepositoryImp extends ChatRepository {
  @override
  Future<List<MessageModel>> getMessagesApi(Map<String, dynamic> map) async {
    List<MessageModel> list = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(tblChatMessages)
        //.where("recieve_by", arrayContains: map["recieverId"])
        //.where("send_by", arrayContains: map["recieverId"])
        .orderBy("send_at", descending: true)
        .get();
    "${querySnapshot.docs.length}".printLog(msg: "getMessagesApi>>>>>>>>>>>>>");

    for (var doc in querySnapshot.docs.reversed) {
      "${doc.data()}".printLog(msg: "getMessagesApi>>>>>>>>>>>>>");
      MessageModel model = MessageModel(
          message: "${doc["message"]}",
          recieve_by: "${doc["recieve_by"]}",
          send_by: "${doc["send_by"]}",
          seen_status: "${doc["seen_status"]}",
          send_at: timeago.format(doc["send_at"].toDate()));
      list.add(model);
    }

    return await list;
  }

  @override
  sendMessage(MessageModel messageModel) async {
    await FirebaseFirestore.instance.collection(tblChatMessages).add({
      "message": messageModel.message,
      "recieve_by": messageModel.recieve_by,
      "send_by": messageModel.send_by,
      "seen_status": messageModel.seen_status,
      "send_at": Timestamp.now(),
    });
  }
}
