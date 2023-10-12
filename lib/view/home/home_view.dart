import 'package:flutter/material.dart';
import 'package:group_chat/view/group_chat_view.dart/group_chat_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController nameController = TextEditingController();
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  void initSocket() {
    socket = IO.io("http://localhost:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
  }

  void joinGroupChat(String name) {
    socket.emit('joinRoom', 'anonymous_group');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupMessageChatScreen(
          name: name,
          userId: socket.id.toString(),
          socket: socket,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Please enter your name'),
                titleTextStyle: TextStyle(fontSize: 16),
                content: TextField(
                  controller: nameController,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      String name = nameController.text.trim();
                      if (name.isNotEmpty) {
                        joinGroupChat(name);
                      }
                    },
                    child: const Text('Enter'),
                  ),
                ],
              ),
            );
          },
          child: const Text('Initiate group chat'),
        ),
      ),
    );
  }
}
