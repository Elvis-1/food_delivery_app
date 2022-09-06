import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_body.dart';
import 'package:food_delivery/pages/auth/signup_screen.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (email.isEmpty) {
        showCustomSnackBar('Type in your email', title: 'Email');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('Type in a valid email address',
            title: 'Email Address');
      } else if (password.isEmpty) {
        showCustomSnackBar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password can not be less than six characters',
            title: 'Password');
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            print('Successful Login');
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading == true
            ? SingleChildScrollView(
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
                          backgroundImage:
                              AssetImage('assets/image/logo part 1.png'),
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
                              fontSize:
                                  Dimension.font20 * 3 + Dimension.font20 / 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Sign into your account",
                            style: TextStyle(
                                fontSize: Dimension.font20,
                                color: Colors.grey[500]),
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
                        isObscure: true,
                        hintText: 'Password',
                        icon: Icons.password_sharp,
                        textController: passwordController),

                    SizedBox(
                      height: Dimension.height20,
                    ),

                    GestureDetector(
                      onTap: () => _login(authController),
                      child: Container(
                        height: Dimension.screenHeight / 13,
                        width: Dimension.screenWidth / 2,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimension.raduis30)),
                        child: Center(
                          child: BigText(
                            text: 'Sign In',
                            color: Colors.white,
                            size: Dimension.font20 + Dimension.font20 / 2,
                          ),
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
                                ..onTap = () => Get.to(SignUpScreen(),
                                    transition: Transition.fade),
                              text: " Create",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainBlackColor,
                                fontSize: Dimension.font20,
                              )),
                        ])),
                  ],
                ),
              )
            : CustomLoader();
      }),
    );
  }
}
