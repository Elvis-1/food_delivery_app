import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_body.dart';
import 'package:food_delivery/routes/route_helper.dart';
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

    void _resgistration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar('Type in your name', title: 'Name');
      } else if (phone.isEmpty) {
        showCustomSnackBar('Type in your phone', title: 'Phone number');
      } else if (email.isEmpty) {
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
        SignUpBody signUpBody = SignUpBody(
            email: email, name: name, phone: phone, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print('Successful registration');
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
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
                        textController: passwordController,
                        isObscure: true,
                      ),
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

                      GestureDetector(
                        onTap: () {
                          _resgistration(authController);
                        },
                        child: Container(
                          height: Dimension.screenHeight / 13,
                          width: Dimension.screenWidth / 2,
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimension.raduis30)),
                          child: Center(
                            child: BigText(
                              text: 'Sign Up',
                              color: Colors.white,
                              size: Dimension.font20 + Dimension.font20 / 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimension.height10,
                      ),
                      // tag line
                      RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "Have an account already?",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimension.font20,
                              ))),
                      SizedBox(height: Dimension.screenHeight * 0.05),
                      RichText(
                          text: TextSpan(
                              text:
                                  "Sign up using one of the following methods",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimension.font16,
                              ))),

                      Wrap(
                        children: List.generate(
                            3,
                            (index) => CircleAvatar(
                                  radius: Dimension.radius20,
                                  backgroundImage: AssetImage(
                                      "assets/image/" + signupImages[index]),
                                )),
                      )
                    ],
                  ),
                )
              : CustomLoader();
        }));
  }
}
