import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore 사용 시 필요
import 'SignupScreen.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore 인스턴스
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController(); // 인증번호 입력 필드 추가
  String _gender = '남성';
  String _verificationId = '';
  bool _isCodeSent = false; // 인증 코드가 전송되었는지 여부

  // E.164 형식으로 전화번호를 변환하는 함수
  String _formatPhoneNumber(String phoneNumber) {
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    return '+82${cleanedNumber.substring(1)}';
  }

  Future<void> _verifyPhoneNumber() async {
    String formattedPhoneNumber = _formatPhoneNumber(_phoneController.text);

    await _auth.verifyPhoneNumber(
      phoneNumber: formattedPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        _saveUserToDatabase(); // 인증이 완료되면 데이터베이스에 사용자 정보를 저장
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
          _isCodeSent = true; // 인증 코드 전송 후 인증번호 입력 필드 표시
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

  void _signInWithSmsCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _smsCodeController.text,
    );
    try {
      await _auth.signInWithCredential(credential);
      _saveUserToDatabase(); // 인증이 완료되면 데이터베이스에 사용자 정보를 저장
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignupScreen()),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Invalid code: $e');
    }
  }

  // Firestore에 사용자 정보 저장
  void _saveUserToDatabase() {
    String uid = _auth.currentUser?.uid ?? '';

    _firestore.collection('users').doc(uid).set({
      'name': _nameController.text,
      'dob': _dobController.text,
      'gender': _gender,
      'phone': _formatPhoneNumber(_phoneController.text),
      'uid': uid,
    }).then((value) {
      Fluttertoast.showToast(msg: 'User data saved successfully');
    }).catchError((error) {
      Fluttertoast.showToast(msg: 'Failed to save user data: $error');
    });
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
                                bottom: 30, left: 17, right: 17),
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
                        // 이름 입력 필드
                        Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Text(
                            "이름",
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
                            "이름을 입력해주세요.",
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: _nameController,
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
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
                        // 생년월일 입력 필드
                        Container(
                          margin: EdgeInsets.only(left: 23),
                          child: Text(
                            "생년월일",
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
                            "생년월일 8자리를 입력해주세요.",
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: _dobController,
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
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
                        // 성별 선택 필드
                        Container(
                          margin: EdgeInsets.only(bottom: 14, left: 24),
                          child: Text(
                            "성별",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
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
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
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
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF000000),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // 전화번호 입력 필드
                        Container(
                          margin: EdgeInsets.only(bottom: 16, left: 25),
                          child: Text(
                            "휴대전화 번호",
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
                            "휴대전화 번호 11자리를 입력해주세요.",
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: _phoneController,
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
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
                        // 인증번호 입력 필드 (코드 전송 후에만 표시)
                        if (_isCodeSent)
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
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: _smsCodeController,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Color(0xFF706F6F),
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "인증번호 입력",
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                horizontal: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        // 인증하기 버튼
                        IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xFFFF9316),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            margin: EdgeInsets.symmetric(horizontal: 100),
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: _isCodeSent ? _signInWithSmsCode : _verifyPhoneNumber,
                              child: Column(children: [
                                Text(
                                  _isCodeSent ? "인증번호 확인" : "인증하기",
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
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
