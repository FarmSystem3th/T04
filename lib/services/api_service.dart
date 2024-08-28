// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  final String baseUrl = 'https://your-fastapi-domain.com';  // 실제 배포된 FastAPI 서버의 URL

  // 인증된 사용자의 토큰을 가져오는 메소드
  Future<String> getAuthToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    return await user?.getIdToken() ?? '';
  }

  // 예시: 채팅방 리스트 가져오기
  Future<List<dynamic>> getChatRooms() async {
    String token = await getAuthToken();
    final response = await http.get(
      Uri.parse('$baseUrl/chat/rooms'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load chat rooms');
    }
  }

  // 예시: 채팅 메시지 전송
  Future<void> sendMessage(int roomId, String message) async {
    String token = await getAuthToken();
    final response = await http.post(
      Uri.parse('$baseUrl/chat/rooms/$roomId/messages'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'content': message,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }

// 다른 API 호출 메소드도 여기서 추가할 수 있습니다.
}
