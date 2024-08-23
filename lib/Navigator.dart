import 'package:flutter/material.dart';
import 'package:app/screens/HomeScreen/HomeScreen.dart';
import 'package:app/screens/ApplyScreen/ApplyScreen.dart';
import 'package:app/screens/ChatScreen/ChatScreen.dart';
import 'package:app/screens/Mypage/MypageMain.dart';
import 'package:app/bottom_icon_icons.dart';

class AppNavigator extends StatefulWidget {
  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  int _currentIndex = 3;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onTap(int index) {
    if (index == _currentIndex) {
      _navigatorKeys[index]
          .currentState
          ?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: List.generate(4, (index) {
          return Offstage(
            offstage: _currentIndex != index,
            child: Navigator(
              key: _navigatorKeys[index],
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => _getScreenForIndex(index),
                );
              },
            ),
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: _onTap,
        selectedItemColor: Color(0xFFFF9416),  // 선택된 아이콘의 색상
        unselectedItemColor: Color(0xFFADADAF),
        items: [
          BottomNavigationBarItem(
              icon: Icon(BottomIcon.home, size: 60),
              label: 'home'
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
      ),
    );
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return ApplyScreen();
      case 2:
        return ChatScreen();
      case 3:
        return MypageMain();
      default:
        return HomeScreen();
    }
  }
}
