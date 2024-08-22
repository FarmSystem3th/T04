import 'package:flutter/material.dart';
class MypageTermsOfUse extends StatelessWidget {
	const MypageTermsOfUse ({super.key});
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
										padding: EdgeInsets.only( top: 23, bottom: 37),
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
														margin: EdgeInsets.only( bottom: 36, left: 17, right: 17),
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
																			"이용 약관",
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
													margin: EdgeInsets.symmetric(horizontal: 26),
													width: double.infinity,
													child: Text(
														"제1장 총칙  제1조(목적) 본 약관은 정부24 (이하 \"당 사이트\")가 제공하는 모든 서비스(이하 \"서비스\")의 이용조건 및 절차, 이용자와 당 사이트의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.   제2조(용어의 정의) 본 약관에서 사용하는 용어의 정의는 다음과 같습니다.  ① 이용자 : 본 약관에 따라 당 사이트가 제공하는 서비스를 이용할 수 있는 자. ② 가 입 : 당 사이트가 제공하는 신청서 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스 이용계약을 완료시키는 행위 ③ 회 원 : 당 사이트에 개인정보 등 관련 정보를 제공하여 회원등록을 한 개인(재외국민, 국내거주 외국인 포함)또는 법인으로서 당 사이트의 정보를 제공 받으며, 당 사이트가 제공하는 서비스를 이용할 수 있는 자. ④ 아이디(ID) : 회원의 식별과 서비스 이용을 위하여 회원이 문자와 숫자의 조합으로 설정한 고유의 체계 ⑤ 비밀번호 : 이용자와 아이디가 일치하는지를 확인하고 통신상의 자신의 비밀보호를 위하여 이용자 자신이 선정한 문자와 숫자의 조합. ⑥ 탈 퇴 : 회원이 이용계약을 종료 시키는 행위  ⑦ 본 약관에서 정의하지 않은 용어는 개별서비스에 대한 별도 약관 및 이용규정에서 정의하거나 일반적인 개념에 의합니다.",
														style: TextStyle(
															color: Color(0xFF000000),
															fontSize: 16,
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