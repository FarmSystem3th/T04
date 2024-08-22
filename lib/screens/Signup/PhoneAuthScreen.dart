import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'SignupScreen.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _gender = '남성';
  String _verificationId = '';

  Future<void> _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(msg: 'Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
        Fluttertoast.showToast(msg: 'Verification code sent');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  void _signInWithSmsCode(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );
    try {
      await _auth.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignupScreen()),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Invalid code: $e');
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
                        IntrinsicHeight(
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: 37, left: 17, right: 17),
                            width: double.infinity,
                            child: Row(children: [
                              Container(
                                margin: EdgeInsets.only(right: 21),
                                width: 6,
                                height: 12,
                                child: Image.network(
                                  "https://i.imgur.com/1tMFzp8.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "회원가입",
                                    style: TextStyle(
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
                            "이름",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 13, left: 25),
                          child: Text(
                            "이름을 입력해주세요.",
                            style: TextStyle(
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
                                top: 20, bottom: 20, left: 20, right: 20),
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
                                        controller: _nameController,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF706F6F),
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "홍길동",
                                          contentPadding: EdgeInsets.symmetric(
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
                            "생년월일",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 17, right: 17),
                            margin: EdgeInsets.only(
                                top: 20, bottom: 20, left: 20, right: 20),
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
                                        controller: _dobController,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF706F6F),
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "YYYY-MM-DD",
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 14, left: 24),
                          child: Text(
                            "성별",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: 14, left: 35, right: 35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Radio<String>(
                                    value: '남성',
                                    groupValue: _gender,
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    "남성",
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: '여성',
                                    groupValue: _gender,
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    "여성",
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 16, left: 25),
                          child: Text(
                            "휴대전화 번호",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 25),
                          child: Text(
                            "휴대전화 번호 11자리를 입력해주세요.",
                            style: TextStyle(
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
                                top: 20, bottom: 20, left: 20, right: 20),
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
                                        controller: _phoneController,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF706F6F),
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "010-1234-5678",
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
                            padding: EdgeInsets.symmetric(vertical: 15),
                            margin: EdgeInsets.symmetric(horizontal: 114),
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: _verifyPhoneNumber,
                              child: Column(children: [
                                Text(
                                  "인증하기",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 16,
                                  ),
                                ),
                              ]),
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
        ),
      ),
    );
  }
}
