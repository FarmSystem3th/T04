import 'package:flutter/material.dart';
import 'package:app/services/api_service.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/main.dart';

class ChatScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  ChatScreen({required this.navigatorKey});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final ApiService apiService = ApiService();
  List<dynamic> chatRooms = [];
  WebSocketChannel? channel;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    await _loadChatRooms();
    await _connectWebSocket();
  }

  Future<void> _loadChatRooms() async {
    try {
      chatRooms = await apiService.getChatRooms();
      setState(() {});
    } catch (e) {
      print('Failed to load chat rooms: $e');
    }
  }

  Future<void> _connectWebSocket() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // 사용자 인증이 되어 있지 않은 경우
        print('User is not logged in');
        return;
      }

      if (user == null) {
        print('User is not logged in');
        // 로그인이 필요하다는 메시지를 보여주거나 로그인 페이지로 리디렉션
        return;
      }

      String? token = await user.getIdToken();

      setState(() {
        channel = IOWebSocketChannel.connect(
          Uri.parse('ws://your-fastapi-domain.com/ws/chat?token=$token'),
        );
      });
    } catch (e) {
      print('Failed to connect to WebSocket: $e');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    channel?.sink.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _syncNavigator();
    }
  }

  void _syncNavigator() {
    final navigatorState = widget.navigatorKey.currentState;
    if (navigatorState != null && navigatorState.canPop()) {
      navigatorState.popUntil((route) => route.isFirst);
    }
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
        title: Text('Chat Room'),
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

// 싹 다 바꿀 필요성 있음
