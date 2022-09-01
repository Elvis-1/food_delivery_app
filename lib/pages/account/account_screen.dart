import 'package:flutter/material.dart';
import 'package:food_delivery/utils/app_icon.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/big_text.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(
          text: 'Profile',
          color: Colors.white,
          size: 24,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimension.height20),
        child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // profile icon
              AppIcon(
                backgroungColor: AppColors.mainColor,
                iconColor: Colors.white,
                icon: Icons.person,
                iconSize: Dimension.height45 + Dimension.height30,
                size: Dimension.height15 * 10,
              ),
              SizedBox(
                height: Dimension.height30,
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    // name
                    AccountWidget(
                      bigText: BigText(text: 'Elvis'),
                      appIcon: AppIcon(
                        backgroungColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        icon: Icons.person,
                        iconSize: Dimension.height10 * 5 / 2,
                        size: Dimension.height10 * 5,
                      ),
                    ),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    // phone
                    AccountWidget(
                      bigText: BigText(text: '878787655555'),
                      appIcon: AppIcon(
                        backgroungColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        icon: Icons.phone,
                        iconSize: Dimension.height10 * 5 / 2,
                        size: Dimension.height10 * 5,
                      ),
                    ),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    // email
                    AccountWidget(
                      bigText: BigText(text: 'ifnotgod@email.com'),
                      appIcon: AppIcon(
                        backgroungColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        icon: Icons.email,
                        iconSize: Dimension.height10 * 5 / 2,
                        size: Dimension.height10 * 5,
                      ),
                    ),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    // address
                    AccountWidget(
                      bigText: BigText(text: 'fill in your address'),
                      appIcon: AppIcon(
                        backgroungColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        icon: Icons.location_on,
                        iconSize: Dimension.height10 * 5 / 2,
                        size: Dimension.height10 * 5,
                      ),
                    ),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    // message
                    AccountWidget(
                      bigText: BigText(text: 'Elvis'),
                      appIcon: AppIcon(
                        backgroungColor: Colors.redAccent,
                        iconColor: Colors.white,
                        icon: Icons.message,
                        iconSize: Dimension.height10 * 5 / 2,
                        size: Dimension.height10 * 5,
                      ),
                    ),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                  ]),
                ),
              )
            ]),
      ),
    );
  }
}
