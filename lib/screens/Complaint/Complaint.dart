import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Complaint extends StatefulWidget {
  final String reportedUserId;

  Complaint({required this.reportedUserId});

  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  String _selectedReason = '스팸/홍보성 계정';
  TextEditingController _otherReasonController = TextEditingController();

  void _submitReport() async {
    String reportReason = _selectedReason == '기타'
        ? _otherReasonController.text.trim()
        : _selectedReason;

    if (_selectedReason == '기타' && reportReason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('기타 사유를 입력해 주세요.')),
      );
      return;
    }

    await FirebaseFirestore.instance
        .collection('reports')
        .add({
      'reportedUserId': widget.reportedUserId,
      'reason': reportReason,
      'timestamp': FieldValue.serverTimestamp(),
    })
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('신고가 접수되었습니다.')),
      );
      Navigator.pop(context);
    })
        .catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('신고 접수에 실패했습니다. 다시 시도해 주세요.')),
      );
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
                    padding: EdgeInsets.symmetric(vertical: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicHeight(
                          child: Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20, left: 17, right: 17),
                            width: double.infinity,
                            child: Row(
                                children: [
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
                                        "신고하기",
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Text(
                            '신고 사유를 선택해 주세요:',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        RadioListTile(
                          title: Text('스팸/홍보성 계정',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),),
                          value: '스팸/홍보성 계정',
                          groupValue: _selectedReason,
                          onChanged: (value) {
                            setState(() {
                              _selectedReason = value!;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text('외설적인 대화',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),),
                          value: '외설적인 대화',
                          groupValue: _selectedReason,
                          onChanged: (value) {
                            setState(() {
                              _selectedReason = value!;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text('욕설/폭언',
                            style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),),
                          value: '욕설/폭언',
                          groupValue: _selectedReason,
                          onChanged: (value) {
                            setState(() {
                              _selectedReason = value!;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text('기타',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),),
                          value: '기타',
                          groupValue: _selectedReason,
                          onChanged: (value) {
                            setState(() {
                              _selectedReason = value!;
                            });
                          },
                        ),
                        if (_selectedReason == '기타')
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: TextField(
                              controller: _otherReasonController,
                              decoration: InputDecoration(
                                labelText: '사유를 입력해 주세요',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 20),
                        IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xFFFF9316),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            margin: EdgeInsets.symmetric(horizontal: 22),
                            width: double.infinity,
                            child: TextButton(
                              onPressed: _submitReport,
                              child: Text(
                                "신고하기",
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


// Container(
// margin: EdgeInsets.symmetric(horizontal: 45),
// child: TextButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Complaint(reportedUserId: "reportedUserId"),
// ),
// );
// },
// child: Text(
// "신고",
// style: TextStyle(
// fontFamily: 'Pretendard',
// fontWeight: FontWeight.w500,
// color: Color(0xFF000000),
// fontSize: 20,
// ),
// )
//
// )
// )
// 채팅창 구현 후 채팅창에서 신고 버튼을 누르면 해당 유저의 id를 넘겨주면 됨