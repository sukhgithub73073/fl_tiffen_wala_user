import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tiffen_wala_user/blocs/auth_bloc/auth_bloc.dart';
import 'package:tiffen_wala_user/blocs/message_bloc/message_bloc.dart';
import 'package:tiffen_wala_user/common/models/message_model.dart';

import 'package:tiffen_wala_user/features/home/chat_screens/own_message_card.dart';
import 'package:tiffen_wala_user/features/home/chat_screens/reply_card.dart';

class IndividualPage extends StatefulWidget {
  final String recieverId;

  IndividualPage({Key? key, required this.recieverId}) : super(key: key);

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;

  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, authState) {
        if (authState is AuthSuccess) {
          return Stack(
            children: [
              Image.asset(
                "assets/images/whatsapp_Back.png",
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: AppBar(
                    leadingWidth: 70,
                    titleSpacing: 0,
                    leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 24,
                          ),
                          CircleAvatar(
                            child: Icon(
                              Icons.verified_user,
                              color: Colors.white,
                              size: 36,
                            ),
                            radius: 20,
                            backgroundColor: Colors.blueGrey,
                          ),
                        ],
                      ),
                    ),
                    title: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name Here",
                              style: TextStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "last seen today at 12:05",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
                      IconButton(icon: Icon(Icons.call), onPressed: () {}),
                      PopupMenuButton<String>(
                        padding: EdgeInsets.all(0),
                        onSelected: (value) {
                          print(value);
                        },
                        itemBuilder: (BuildContext contesxt) {
                          return [
                            PopupMenuItem(
                              child: Text("View Contact"),
                              value: "View Contact",
                            ),
                            PopupMenuItem(
                              child: Text("Media, links, and docs"),
                              value: "Media, links, and docs",
                            ),
                            PopupMenuItem(
                              child: Text("Whatsapp Web"),
                              value: "Whatsapp Web",
                            ),
                            PopupMenuItem(
                              child: Text("Search"),
                              value: "Search",
                            ),
                            PopupMenuItem(
                              child: Text("Mute Notification"),
                              value: "Mute Notification",
                            ),
                            PopupMenuItem(
                              child: Text("Wallpaper"),
                              value: "Wallpaper",
                            ),
                          ];
                        },
                      ),
                    ],
                  ),
                ),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: WillPopScope(
                    child: Column(
                      children: [
                        Expanded(
                          // height: MediaQuery.of(context).size.height - 150,
                          child: BlocConsumer<MessageBloc, MessageState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is MessageSuccess) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: state.messagesList.length,
                                  itemBuilder: (context, index) {
                                    if (state.messagesList[index].send_by ==
                                        authState.userModel.uid) {
                                      return OwnMessageCard(
                                        message:
                                            state.messagesList[index].message,
                                        time: state.messagesList[index].send_at,
                                      );
                                    } else {
                                      return ReplyCard(
                                        message:
                                            state.messagesList[index].message,
                                        time: state.messagesList[index].send_at,
                                      );
                                    }
                                  },
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          60,
                                      child: Card(
                                        margin: EdgeInsets.only(
                                            left: 2, right: 2, bottom: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: TextFormField(
                                          controller: _controller,
                                          focusNode: focusNode,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 2,
                                          minLines: 1,
                                          onChanged: (value) {
                                            if (value.length > 0) {
                                              setState(() {
                                                sendButton = true;
                                              });
                                            } else {
                                              setState(() {
                                                sendButton = false;
                                              });
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Type a message",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            prefixIcon: IconButton(
                                              icon: Icon(
                                                show
                                                    ? Icons.keyboard
                                                    : Icons
                                                        .emoji_emotions_outlined,
                                              ),
                                              onPressed: () {
                                                if (!show) {
                                                  focusNode.unfocus();
                                                  focusNode.canRequestFocus =
                                                      false;
                                                }
                                                setState(() {
                                                  show = !show;
                                                });
                                              },
                                            ),
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.attach_file),
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (builder) =>
                                                            bottomSheet());
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.camera_alt),
                                                  onPressed: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (builder) =>
                                                    //             CameraApp()));
                                                  },
                                                ),
                                              ],
                                            ),
                                            contentPadding: EdgeInsets.all(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    BlocConsumer<MessageBloc, MessageState>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8,
                                            right: 2,
                                            left: 2,
                                          ),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Color(0xFF128C7E),
                                            child: IconButton(
                                              icon: Icon(
                                                sendButton
                                                    ? Icons.send
                                                    : Icons.mic,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                if (sendButton) {
                                                  _scrollController.animateTo(
                                                      _scrollController.position
                                                          .maxScrollExtent,
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.easeOut);

                                                  var model = MessageModel(
                                                      message: _controller.text,
                                                      recieve_by:
                                                          "${widget.recieverId}",
                                                      send_by:
                                                          "${authState.userModel.uid}",
                                                      seen_status: "0",
                                                      send_at: "Now");

                                                  context
                                                      .read<MessageBloc>()
                                                      .add(SendMessageEvent(
                                                          messageModel: model));

                                                  if (state is MessageSuccess) {
                                                    state.messagesList
                                                        .add(model);
                                                  }
                                                  _controller.clear();
                                                  setState(() {
                                                    sendButton = false;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    onWillPop: () {
                      if (show) {
                        setState(() {
                          show = false;
                        });
                      } else {
                        Navigator.pop(context);
                      }
                      return Future.value(false);
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }
}
