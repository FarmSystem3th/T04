import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/authProvider.dart';
import 'package:app/screens/HomeScreen/HomeScreen.dart';
import 'package:app/screens/ApplyScreen/ApplyScreen.dart';
import 'package:app/screens/ChatScreen/ChatScreen.dart';
import 'package:app/screens/Mypage/MypageMain.dart';
import 'package:app/screens/Login/LoginScreen.dart';
import 'package:app/bottom_icon_icons.dart';

class AppNavigator extends StatefulWidget {
  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  int currentIndex = 0;
  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void onTap(int index) {
    if (index == currentIndex) {
      navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentIndex = index;
        navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
      });
    }
  }

  Future<void> logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.logout(); // 로그아웃 처리

    setState(() {
      currentIndex = 0; // 홈 화면으로 리셋
    });

    // 모든 네비게이터의 스택을 초기화합니다.
    for (final key in navigatorKeys) {
      key.currentState?.popUntil((route) => route.isFirst);
    }

    // 로그인 화면으로 리다이렉트
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = Provider.of<AuthProvider>(context).isLoggedIn;

    return Scaffold(
      body: isLoggedIn
          ? Stack(
        children: List.generate(4, (index) {
          return Offstage(
            offstage: currentIndex != index,
            child: Navigator(
              key: navigatorKeys[index],
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => _getScreenForIndex(index),
                );
              },
            ),
          );
        }),
      )
          : LoginScreen(), // 로그인되지 않은 경우 로그인 화면을 표시
      bottomNavigationBar: isLoggedIn
          ? BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: Color(0xFFFF9416),
        unselectedItemColor: Color(0xFFADADAF),
        items: [
          BottomNavigationBarItem(
            icon: Icon(BottomIcon.home, size: 60),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(BottomIcon.apply, size: 60),
            label: 'apply',
          ),
          BottomNavigationBarItem(
            icon: Icon(BottomIcon.chat, size: 60),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(BottomIcon.account, size: 60),
            label: 'account',
          ),
        ],
      )
          : null, // 로그인되지 않은 경우 네비게이션 바 숨김
    );
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return HomeScreen(navigatorKey: navigatorKeys[index]);
      case 1:
        return ApplyScreen(navigatorKey: navigatorKeys[index]);
      case 2:
        return ChatScreen(navigatorKey: navigatorKeys[index]);
      case 3:
        return MypageMain(navigatorKey: navigatorKeys[index]);
      default:
        return HomeScreen(navigatorKey: navigatorKeys[index]);
    }
  }
}
