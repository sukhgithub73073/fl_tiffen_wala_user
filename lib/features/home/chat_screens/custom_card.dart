import 'package:flutter/material.dart';

import 'package:tiffen_wala_user/common/models/chat_model.dart';
import 'package:tiffen_wala_user/features/home/chat_screens/individual_page.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.chatModel, required this.sourchat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) => IndividualPage(
                  recieverId: "",

                )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.co2,
                color: Colors.white,
                size: 36,

              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              chatModel.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chatModel.currentMessage,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
