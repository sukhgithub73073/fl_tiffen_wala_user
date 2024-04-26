import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/models/chat_model.dart';
import 'package:tiffen_wala_user/features/home/chat_screens/custom_card.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  var textTheme;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Dev Stack",
      isGroup: false,
      currentMessage: "Hi Everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1,
      status: '0',
    ),
    ChatModel(
      name: "Kishor",
      isGroup: false,
      currentMessage: "Hi Kishor",
      time: "13:00",
      icon: "person.svg",
      id: 2,
      status: '0',
    ),

    ChatModel(
      name: "Collins",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "8:00",
      icon: "person.svg",
      id: 3,
      status: '0',
    ),

    ChatModel(
      name: "Balram Rathore",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "2:00",
      icon: "person.svg",
      id: 4,
      status: '0',
    ),
  ];

  var sourceChat ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sourceChat = chatmodels.removeAt(0);
  }


  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_rounded,
        ),
        title: Text(
          "Chat List",
          style: textTheme?.labelLarge?.copyWith(fontSize: 20.0),
        ),
      ),
      body: ListView.builder(
        itemCount: chatmodels.length,
        itemBuilder: (contex, index) => CustomCard(
          chatModel: chatmodels[index],
          sourchat: sourceChat,
        ),
      ),
    );
  }
}
