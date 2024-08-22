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
							Expanded(
								child: Container(
									color: Color(0xFFF5F5F8),
									width: double.infinity,
									height: double.infinity,
									child: SingleChildScrollView(
										padding: EdgeInsets.only( top: 23, bottom: 334),
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												IntrinsicHeight(
													child: Container(
														margin: EdgeInsets.only( bottom: 30, left: 33, right: 33),
														width: double.infinity,
														child: Row(
															children: [
																Expanded(
																	child: Container(
																		margin: EdgeInsets.only( right: 4),
																		width: double.infinity,
																		child: Text(
																			"9:41",
																			style: TextStyle(
																				color: Color(0xFF000000),
																				fontSize: 17,
																			),
																		),
																	),
																),
																Container(
																	margin: EdgeInsets.only( right: 8),
																	width: 19,
																	height: 12,
																	child: Image.network(
																		"https://i.imgur.com/1tMFzp8.png",
																		fit: BoxFit.fill,
																	)
																),
																Container(
																	margin: EdgeInsets.only( right: 7),
																	width: 17,
																	height: 12,
																	child: Image.network(
																		"https://i.imgur.com/1tMFzp8.png",
																		fit: BoxFit.fill,
																	)
																),
																IntrinsicHeight(
																	child: Container(
																		decoration: BoxDecoration(
																			border: Border.all(
																				color: Color(0xFF000000),
																				width: 1,
																			),
																			borderRadius: BorderRadius.circular(4),
																		),
																		padding: EdgeInsets.only( left: 2, right: 2),
																		margin: EdgeInsets.only( right: 1),
																		width: 25,
																		child: Column(
																			crossAxisAlignment: CrossAxisAlignment.start,
																			children: [
																				Container(
																					decoration: BoxDecoration(
																						borderRadius: BorderRadius.circular(2),
																						color: Color(0xFF000000),
																					),
																					margin: EdgeInsets.only( top: 2),
																					height: 9,
																					width: double.infinity,
																					child: SizedBox(),
																				),
																			]
																		),
																	),
																),
																Container(
																	color: Color(0xFF000000),
																	width: 1,
																	height: 4,
																	child: SizedBox(),
																),
															]
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														margin: EdgeInsets.only( bottom: 56, left: 17, right: 17),
														width: double.infinity,
														child: Row(
															children: [
																Container(
																	margin: EdgeInsets.only( right: 21),
																	width: 6,
																	height: 12,
																	child: Image.network(
																		"https://i.imgur.com/1tMFzp8.png",
																		fit: BoxFit.fill,
																	)
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
															]
														),
													),
												),
												Container(
													margin: EdgeInsets.only( bottom: 40, left: 32),
													child: Text(
														"오늘 점심 메뉴는 무엇인가요?",
														style: TextStyle(
															color: Color(0xFF000000),
															fontSize: 17,
														),
													),
												),
												Container(
													margin: EdgeInsets.only( bottom: 46, left: 32),
													child: Text(
														"오늘 저녁 메뉴는 무엇인가요?",
														style: TextStyle(
															color: Color(0xFF000000),
															fontSize: 17,
														),
													),
												),
												Container(
													margin: EdgeInsets.only( bottom: 40, left: 32),
													child: Text(
														"한전 mcs는 뭐하는 회사죠?",
														style: TextStyle(
															color: Color(0xFF000000),
															fontSize: 17,
														),
													),
												),
												Container(
													margin: EdgeInsets.only( bottom: 38, left: 32),
													child: Text(
														"오늘의 커피는 어떤 원두죠?",
														style: TextStyle(
															color: Color(0xFF000000),
															fontSize: 17,
														),
													),
												),
												Container(
													margin: EdgeInsets.only( bottom: 42, left: 32),
													child: Text(
														"한화가 가을야구를 갈 수 있나요?",
														style: TextStyle(
															color: Color(0xFF000000),
															fontSize: 17,
														),
													),
												),
												Container(
													margin: EdgeInsets.only( bottom: 46, left: 32),
													child: Text(
														"강아지가 먹는 풀은 강아지풀인가요?",
														style: TextStyle(
															color: Color(0xFF000000),
															fontSize: 17,
														),
													),
												),
												Container(
													margin: EdgeInsets.only( left: 32),
													child: Text(
														"저희 완성할 수 있겠죠?",
														style: TextStyle(
															color: Color(0xFF000000),
															fontSize: 17,
														),
													),
												),
											],
										)
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