import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/presentation/controllers/auth/login/login_controller.dart';
import 'package:hoc24/presentation/widgets/app_button.dart';
import 'package:hoc24/presentation/widgets/name_divider.dart';
import 'package:hoc24/presentation/widgets/social_icon.dart';

class Welcome extends GetView<LoginController> {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/vietnam.jpeg',
                      width: size.width * 0.5,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SizedBox(
                    width: size.width * 0.85,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: const [
                            TextSpan(
                              text: 'Chào mừng bạn đến với ',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF141416),
                                decoration: TextDecoration.none,
                                height: 1.5,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            TextSpan(
                              text: 'Tourly',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.dark,
                                decoration: TextDecoration.none,
                                height: 1.5,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  SizedBox(
                    width: size.width * 0.85,
                    child: const Text(
                      'Ứng dụng hỗ trợ du lịch',
                      style: TextStyle(fontSize: 18, height: 1.25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: size.height * 0.08),
                  AppButton(
                    text: 'Đăng nhập',
                    onPressed: () {},
                  ),
                  AppButton(
                    text: 'Đăng ký',
                    backgroundColor: Colors.white,
                    textColor: AppColors.dark,
                    onPressed: () {},
                  ),
                  SizedBox(height: size.height * 0.1),
                  const NameDivider(text: 'Hoặc tiếp tục với'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialIcon(iconSrc: 'assets/images/facebook.png', onPressed: () {}),
                      SocialIcon(
                          iconSrc: 'assets/images/google.png',
                          onPressed: () {
                            // login.signInWithGoogle(context: context);
                          }),
                      SocialIcon(iconSrc: 'assets/images/apple.png', onPressed: () {})
                    ],
                  )
                ],
              ),
            ),
          ),
          // isLoading
          //     ? Positioned.fill(
          //         child: Container(
          //           color: Colors.black.withOpacity(0.5),
          //           child: const Center(
          //             child: CircularProgressIndicator(),
          //           ),
          //         ),
          //       )
          //     : const Center(child: null),
        ],
      ),
    );
  }
}
