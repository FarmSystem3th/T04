import 'package:flutter/material.dart';
import 'package:app/screens/Mypage/MypageFAQ.dart';
import 'package:app/screens/Mypage/MypageAccountInfo.dart';
import 'package:app/screens/Mypage/MypageManual.dart';
import 'package:app/screens/Mypage/MypagePrivacyPolicy.dart';
import 'package:app/screens/Mypage/MypageTermsOfUse.dart';
import 'package:app/screens/HomeScreen/HomeScreen.dart';
import 'package:app/Navigator.dart';

class MypageMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Page"),
      ),
      body: Container(
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
                      _buildMenuItem(context, "내 계정 정보", MypageAccountInfo()),
                      _buildMenuItem(context, "쉽게 시작하는 조청 설명서", MypageManual()),
                      _buildMenuItem(context, "자주 묻는 질문", MypageFaq()),
                      _buildMenuItem(context, "개인정보 처리 방침", MypagePrivacyPolicy()),
                      _buildMenuItem(context, "이용약관", MypageTermsOfUse()),
                      _buildLogoutButton(context),
                      _buildWithdrawButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, Widget page) {
    return Container(
      margin: EdgeInsets.only(bottom: 32, left: 41),
      child: TextButton(
        child: Text(
          title,
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 20,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32, left: 41),
      child: TextButton(
        child: Text(
          "로그아웃",
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 20,
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return _buildLogoutModal(
                context,
                "정말 로그아웃 하시나요?",
                "로그아웃하시나요?",
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildWithdrawButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 200, left: 41),
      child: TextButton(
        child: Text(
          "계정 탈퇴",
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 20,
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return _buildWithdrawModal(
                context,
                "정말 계정을 탈퇴하시겠습니까?",
                "계정을 한번 탈퇴하면 정보를 복구할 수 없습니다.\n정말 탈퇴하시겠습니까?",
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLogoutModal(BuildContext context, String message, String subtitle) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 20,
            ),
          ),
          SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF757575),
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomeScreen()),
              //       (route) => false,
              // );
            },
            child: Text(
              "로그아웃",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF9416),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "포기하기",
              style: TextStyle(
                color: Color(0xFFFF9416),
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawModal(BuildContext context, String message, String subtitle) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 20,
            ),
          ),
          SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF757575),
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomeScreen()),
              //       (route) => false,
              // );
            },
            child: Text(
              "탈퇴하기",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF9416),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "포기하기",
              style: TextStyle(
                color: Color(0xFFFF9416),
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ],
      ),
    );
  }
}
