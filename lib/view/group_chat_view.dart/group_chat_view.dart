import 'package:flutter/material.dart';
import 'package:group_chat/color.dart';
import 'package:group_chat/model/msg_model.dart';
import 'package:group_chat/utils.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GroupMessageChatScreen extends StatefulWidget {
  final String name, userId;
  final IO.Socket socket;

  const GroupMessageChatScreen({
    Key? key,
    required this.name,
    required this.userId,
    required this.socket,
  }) : super(key: key);

  @override
  State<GroupMessageChatScreen> createState() => _GroupMessageChatScreenState();
}

class _GroupMessageChatScreenState extends State<GroupMessageChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  void initSocket() {
    widget.socket.on('sendMsg', (msg) {
      print(msg);
      setState(() {
        messages.add(MessageModel(
          msg: msg['msg'],
          senderId: msg['senderId'].toString(),
          senderName: msg['senderName'],
          type: msg['type'],
          time: msg['time'],
        ));
      });
    });
  }

  void sendMessage(String msg) {
    widget.socket.emit('sendMsg', {
      'type': 'ownMsg',
      'msg': msg,
      'senderName': widget.name,
      'time': DateTime.now().microsecondsSinceEpoch.toString(),
      'senderId': widget.userId,
      'room': 'anonymous_group',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Anonymous group')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isOwnMessage = message.senderId == widget.userId;
                // Convert the timestamp String to DateTime
                // Convert the timestamp String to DateTime
                DateTime messageDateTime = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(message.time));

                return Row(
                  mainAxisAlignment: isOwnMessage
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 207, 174, 213),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                          ),
                          child: Center(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(message.msg),
                              const SizedBox(height: 5),
                              Text(
                                message.senderName,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(6),
                          child: Text(
                            DateFormat('h:mm a').format(messageDateTime),
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: const CircleAvatar(
                    child: Icon(Icons.camera_alt),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    minLines: 1,
                    maxLines: 5,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 14, height: 1),
                    decoration: InputDecoration(
                      hintText: 'Write a Message',
                      contentPadding: const EdgeInsets.only(left: 20),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(height: 1, color: AppColors.otpHintColor),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.whiteColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    if (messageController.text.isNotEmpty) {
                      sendMessage(messageController.text.trim());
                      messageController.clear();
                    } else {
                      Utils.toastMessage('Enter Message..!');
                    }
                  },
                  child: const CircleAvatar(
                    child: Icon(Icons.send),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
