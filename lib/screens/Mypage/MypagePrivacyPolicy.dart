import 'package:flutter/material.dart';
class MypagePrivacyPolicy extends StatelessWidget {
	const MypagePrivacyPolicy({super.key});
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
														margin: EdgeInsets.only( bottom: 52, left: 17, right: 17),
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
																			"개인정보 처리 방침",
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
													margin: EdgeInsets.only( bottom: 37, left: 48, right: 48),
													width: double.infinity,
													child: Text(
														"개인정보보호위원회(이하 `개인정보위\'라 한다)는 정보주체의 자유와 권리 보호를 위해 「개인정보 보호법」 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. 이에 「개인정보 보호법」 제30조에 따라 정보주체에게 개인정보 처리에 관한 절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립 ‧ 공개합니다.",
														style: TextStyle(
															color: Color(0xFF000000),
															fontSize: 18,
														),
													),
												),
												Container(
													margin: EdgeInsets.symmetric(horizontal: 45),
													width: double.infinity,
													child: Text(
														"개인정보보호위원회(이하 `개인정보위\'라 한다)는 정보주체의 자유와 권리 보호를 위해 「개인정보 보호법」 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. 이에 「개인정보 보호법」 제30조에 따라 정보주체에게 개인정보 처리에 관한 절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립 ‧ 공개합니다.",
														style: TextStyle(
															color: Color(0xFF000000),
															fontSize: 18,
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