import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  void _registerUser() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      Fluttertoast.showToast(msg: 'Passwords do not match!');
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'userID': _idController.text,
        'password': _passwordController.text,
      });

      Fluttertoast.showToast(msg: 'User registration completed!');
      // Optionally, navigate to a home screen or another screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                      padding: EdgeInsets.symmetric(vertical: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 기존 UI 구성 요소들
                          IntrinsicHeight(
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: 37, left: 17, right: 17),
                              width: double.infinity,
                              child: Row(children: [
                                Container(
                                  child: IconButton(
                                    icon: Image.asset("assets/images/back.png", color: Color(0xFF000000), fit: BoxFit.contain),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      "회원가입",
                                      style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF000000),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 24),
                            child: Text(
                              "아이디",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child: Text(
                              "영소문자 포함 a-b자 이내",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          IntrinsicHeight(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 20, left: 17, right: 17),
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 20, left: 20, right: 20),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 353,
                                      height: 50,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                            color: Color(0xFFFF0000),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: _idController,
                                          style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Color(0xFF706F6F),
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "예시: abc123",
                                            contentPadding: EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 23),
                            child: Text(
                              "비밀번호",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child: Text(
                              "비밀번호 c자리 이상 d자리 이하",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          IntrinsicHeight(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 20, left: 17, right: 17),
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 20, left: 20, right: 20),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 353,
                                      height: 50,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                            color: Color(0xFFFF0000),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: _passwordController,
                                          style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Color(0xFF706F6F),
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "예시: qwe123",
                                            contentPadding: EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 23),
                            child: Text(
                              "비밀번호 확인",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child: Text(
                              "동일한 비밀번호를 입력해주세요.",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          IntrinsicHeight(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 20, left: 17, right: 17),
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 20, left: 20, right: 20),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 353,
                                      height: 50,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                            color: Color(0xFFFF0000),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: _confirmPasswordController,
                                          style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Color(0xFF706F6F),
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "예시: qwe123",
                                            contentPadding: EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          IntrinsicHeight(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Color(0xFFFF9316),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 5),
                              margin: EdgeInsets.symmetric(horizontal: 100),
                              width: double.infinity,
                              child: TextButton(
                                onPressed: _registerUser,
                                child: Text('가입하기'),
                                style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}