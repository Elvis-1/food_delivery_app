import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/signup_screen.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Dimension.screenHeight * 0.05,
            ),
            // app logo
            Container(
              height: Dimension.screenHeight * 0.25,
              child: const Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/image/logo part 1.png'),
                ),
              ),
            ),
            // welcome
            Container(
              margin: EdgeInsets.only(left: Dimension.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: Dimension.font20 * 3 + Dimension.font20 / 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign into your account",
                    style: TextStyle(
                        fontSize: Dimension.font20, color: Colors.grey[500]),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Dimension.height20,
            ),
            // your email
            AppTextField(
                hintText: 'Email',
                icon: Icons.email,
                textController: emailController),
            SizedBox(
              height: Dimension.height20,
            ),
            // your password
            AppTextField(
                hintText: 'Password',
                icon: Icons.password_sharp,
                textController: passwordController),

            SizedBox(
              height: Dimension.height20,
            ),

            Container(
              height: Dimension.screenHeight / 13,
              width: Dimension.screenWidth / 2,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimension.raduis30)),
              child: Center(
                child: BigText(
                  text: 'Sign In',
                  color: Colors.white,
                  size: Dimension.font20 + Dimension.font20 / 2,
                ),
              ),
            ),
            SizedBox(
              height: Dimension.height20,
            ),
            // tag line
            Row(
              children: [
                Expanded(child: Container()),
                RichText(
                    text: TextSpan(
                        text: "Sign into your account",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimension.font20,
                        ))),
                SizedBox(
                  width: Dimension.width20,
                ),
              ],
            ),

            SizedBox(height: Dimension.screenHeight * 0.05),
            RichText(
                text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimension.font20,
                    ),
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            Get.to(SignUpScreen(), transition: Transition.fade),
                      text: " Create",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainBlackColor,
                        fontSize: Dimension.font20,
                      )),
                ])),
          ],
        ),
      ),
    );
  }
}
