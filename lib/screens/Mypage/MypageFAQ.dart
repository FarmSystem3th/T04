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
							Container(
									width: 20,
									height: 20,
								child: IconButton(
									icon: Image.asset("assets/images/back.png", color: Color(0xFF000000), width: 20,height: 50, fit: BoxFit.fill),
									onPressed: () {
										Navigator.pop(context);
									},
								),
							),
							Expanded(
								child: Container(
									width: double.infinity,
									child: Text(
										"자주 묻는 질문",
										style: TextStyle(
											color: Color(0xFF000000),
											fontSize: 17,
										),
									),
								),
							),
							],
					),
				),
					),
							Container(
								margin: EdgeInsets.only(bottom: 40, left: 32),
								child: Text(
									"오늘 점심 메뉴는 무엇인가요?",
									style: TextStyle(
										color: Color(0xFF000000),
										fontSize: 17,
									),
								),
							),
							Container(
								margin: EdgeInsets.only(bottom: 46, left: 32),
								child: Text(
									"오늘 저녁 메뉴는 무엇인가요?",
									style: TextStyle(
										color: Color(0xFF000000),
										fontSize: 17,
									),
								),
							),
							Container(
								margin: EdgeInsets.only(bottom: 40, left: 32),
								child: Text(
									"한전 mcs는 뭐하는 회사죠?",
									style: TextStyle(
										color: Color(0xFF000000),
										fontSize: 17,
									),
								),
							),
							Container(
								margin: EdgeInsets.only(bottom: 38, left: 32),
								child: Text(
									"오늘의 커피는 어떤 원두죠?",
									style: TextStyle(
										color: Color(0xFF000000),
										fontSize: 17,
									),
								),
							),
							Container(
								margin: EdgeInsets.only(bottom: 42, left: 32),
								child: Text(
									"한화가 가을야구를 갈 수 있나요?",
									style: TextStyle(
										color: Color(0xFF000000),
										fontSize: 17,
									),
								),
							),
							Container(
								margin: EdgeInsets.only(bottom: 46, left: 32),
								child: Text(
									"강아지가 먹는 풀은 강아지풀인가요?",
									style: TextStyle(
										color: Color(0xFF000000),
										fontSize: 17,
									),
								),
							),
							Container(
								margin: EdgeInsets.only(left: 32),
								child: Text(
									"저희 완성할 수 있겠죠?",
									style: TextStyle(
										color: Color(0xFF000000),
										fontSize: 17,
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