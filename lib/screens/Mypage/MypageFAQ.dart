import 'package:flutter/material.dart';

class MypageFaq extends StatelessWidget {
  const MypageFaq({super.key});

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
              IntrinsicHeight(
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 45, left: 17, right: 17),
                  width: double.infinity,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Image.asset("assets/images/back.png",
                            color: Color(0xFF000000), fit: BoxFit.contain),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Text(
                          "자주 묻는 질문",
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000),
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildFaqTile("오늘 점심 메뉴는 무엇인가요?", "오늘의 점심 메뉴는 비빔밥입니다."),
                    _buildFaqTile("오늘 저녁 메뉴는 무엇인가요?", "오늘의 저녁 메뉴는 된장찌개입니다."),
                    _buildFaqTile("한전 mcs는 뭐하는 회사죠?", "한전 MCS는 전력 관련 서비스를 제공하는 회사입니다."),
                    _buildFaqTile("오늘의 커피는 어떤 원두죠?", "콜롬비아 원두입니다."),
                    _buildFaqTile("한화가 가을야구를 갈 수 있나요?", "네, 갈 수 있습니다. 99번 류현진과 1번 문동주를 필두로 오랜만에 가을야구를 갈 수 있겠습니다. 오오오 최강한화 김인환 워어 승리를 위해 외쳐라"),
                    _buildFaqTile("강아지가 먹는 풀은 강아지풀인가요?", "강아지가 먹는 풀은 강아지풀입니다."),
                    _buildFaqTile("저희 완성할 수 있겠죠?", "네, 열심히 하면 가능합니다!"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqTile(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          color: Color(0xFF000000),
          fontSize: 17,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 10),
          child: Text(
            answer,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              color: Color(0xFF555555),
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
