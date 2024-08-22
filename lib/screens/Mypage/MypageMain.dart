import 'package:app/screens/Mypage/MypageFAQ.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/MainScreen.dart';
import 'package:app/screens/ApplyScreen.dart';
import 'package:app/screens/Mypage/MypageAccountInfo.dart';
import 'package:app/screens/Mypage/MypageManual.dart';
import 'package:app/screens/Mypage/MypagePrivacyPolicy.dart';
import 'package:app/screens/Mypage/MypageTermsOfUse.dart';
import 'package:app/screens/ChatScreen.dart';
import 'package:app/bottom_icon_icons.dart';

class MypageMain extends StatefulWidget {
  const MypageMain({super.key});

  @override
  State<MypageMain> createState() => _MypageMain();
}

class _MypageMain extends State<MypageMain> {
  int _index = 3;  // 초기값을 3으로 설정하여 MypageMain이 기본으로 표시되도록 설정

  final List<Widget> _pages = [
    MainScreen(),
    ApplyScreen(),
    ChatScreen(),
    MypageMainContent(), // 여기서는 MypageMain의 기존 내용을 담을 위젯을 추가
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
              activeIcon: Icon(BottomIcon.home_red)),
          BottomNavigationBarItem(
              icon: Icon(BottomIcon.apply),
              label: 'apply',
              activeIcon: Icon(BottomIcon.apply_red)),
          BottomNavigationBarItem(
              icon: Icon(BottomIcon.chat),
              label: 'chat',
              activeIcon: Icon(BottomIcon.chat_red)),
          BottomNavigationBarItem(
              icon: Icon(BottomIcon.account),
              label: 'account',
              activeIcon: Icon(BottomIcon.account_red)),
        ],
      ),
    );
  }
}

// MypageMain의 기존 내용을 별도의 위젯으로 분리
class MypageMainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: Color(0xFFF5F5F8),
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 32, left: 41),
                      child: TextButton(
                        child: Text(
                          "내 계정 정보",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MypageAccountInfo()),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 32, left: 40),
                      child: TextButton(
                        child: Text(
                          "쉽게 시작하는 조청 설명서",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MypageManual()),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 32, left: 40),
                      child: TextButton(
                        child: Text(
                          "자주 묻는 질문",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MypageFaq()),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 32, left: 41),
                      child: TextButton(
                        child: Text(
                          "개인정보 처리 방침",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MypagePrivacyPolicy()),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 32, left: 41),
                      child: TextButton(
                        child: Text(
                          "이용약관",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MypageTermsOfUse()),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 32, left: 41),
                      child: Text(
                        "로그아웃",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 200, left: 41),
                      child: Text(
                        "계정 탈퇴",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
