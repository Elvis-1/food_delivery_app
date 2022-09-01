import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signupImages = ['t.png', 'f.png', 'g.png'];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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

          // your name
          AppTextField(
              hintText: 'Name',
              icon: Icons.person,
              textController: nameController),
          SizedBox(
            height: Dimension.height20,
          ),

          // your phone
          AppTextField(
              hintText: 'Phone',
              icon: Icons.phone,
              textController: phoneController),
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
                text: 'Sign Up',
                color: Colors.white,
                size: Dimension.font20 + Dimension.font20 / 2,
              ),
            ),
          ),
          SizedBox(
            height: Dimension.height10,
          ),
          // tag line
          RichText(
              text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                  text: "Have an account already?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimension.font20,
                  ))),
          SizedBox(height: Dimension.screenHeight * 0.05),
          RichText(
              text: TextSpan(
                  text: "Sign up using one of the following methods",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimension.font16,
                  ))),

          Wrap()
        ],
      ),
    );
  }
}
