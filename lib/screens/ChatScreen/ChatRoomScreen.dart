import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRoomScreen extends StatefulWidget {
  final String roomId;

  ChatRoomScreen({required this.roomId});

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  WebSocketChannel? channel;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  Future<void> _connectWebSocket() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print('User is not logged in');
        return;
      }

      String? token = await user.getIdToken();

      setState(() {
        channel = IOWebSocketChannel.connect(
          Uri.parse('ws://your-fastapi-domain.com/ws/chat/${widget.roomId}?token=$token'),
        );
      });
    } catch (e) {
      print('Failed to connect to WebSocket: $e');
    }
  }

  @override
  void dispose() {
    channel?.sink.close();
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty && channel != null) {
      channel!.sink.add(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room: ${widget.roomId}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: channel?.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data.toString()),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No messages'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter your message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
