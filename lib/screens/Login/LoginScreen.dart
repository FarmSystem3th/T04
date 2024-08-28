import 'package:app/screens/Signup/PhoneAuthScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/authProvider.dart';
import 'package:app/Navigator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userIDController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final userID = _userIDController.text;
      final password = _passwordController.text;

      final querySnapshot = await firestore
          .collection('users')
          .where('userID', isEqualTo: userID)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first;

        if (userDoc['password'] == password) {
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          authProvider.login(); // 로그인 처리
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AppNavigator()),
            (route) => false,
          );
        } else {
          print('Incorrect password');
        }
      } else {
        print('User not found');
      }
    } catch (e) {
      print('Error during login: $e');
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
                                bottom: 10, left: 17, right: 17),
                            width: double.infinity,
                            child: Row(children: [
                              Container(
                                child: IconButton(
                                  icon: Image.asset("assets/images/back.png",
                                      color: Color(0xFF000000),
                                      fit: BoxFit.contain),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "로그인",
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF000000),
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                             left: 95),
                          child: Image.asset(
                            "assets/images/LoginLOGO.png",
                            width: 200,
                            height: 200,
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 23),
                        //   child: Text(
                        //     "아이디",
                        //     style: TextStyle(
                        //       fontFamily: 'Pretendard',
                        //       fontWeight: FontWeight.w600,
                        //       color: Color(0xFF000000),
                        //       fontSize: 20,
                        //     ),
                        //   ),
                        // ),
                        IntrinsicHeight(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 17, right: 17),
                            margin: EdgeInsets.only(
                                top: 10, left: 20, right: 20),
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: _userIDController,
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Color(0xFF706F6F),
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '아이디',
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 23),
                        //   child: Text(
                        //     "비밀번호",
                        //     style: TextStyle(
                        //       fontFamily: 'Pretendard',
                        //       fontWeight: FontWeight.w600,
                        //       color: Color(0xFF000000),
                        //       fontSize: 20,
                        //     ),
                        //   ),
                        // ),
                        IntrinsicHeight(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 17, right: 17),
                            margin: EdgeInsets.only(
                                bottom:20, left: 20, right: 20),
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: true,
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Color(0xFF706F6F),
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '비밀번호',
                                          contentPadding: EdgeInsets.symmetric(
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
                              onPressed: _login,
                              child: Text(
                                "로그인",
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhoneAuthScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "회원가입",
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8F8F8F),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(width: 80),
                            SizedBox(width: 20),
                            TextButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => Screen(),
                                //   ),
                                // );
                                // 아이디/비밀번호 찾기 화면으로 이동
                              },
                              child: Text(
                                "아이디/비밀번호가 기억나지 않나요?",
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF824A47),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
