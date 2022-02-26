import 'package:flutter/material.dart';
import 'package:food_delivery/utils/app_icon.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimension.radius20),
                      topRight: Radius.circular(Dimension.radius20),
                    )),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Center(
                    child:
                        BigText(size: Dimension.font26, text: 'Chinese Side')),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/image/food0.png',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimension.width20, right: Dimension.width20),
                  child: ExpandableTextWidget(
                    text:
                        'God is good to me, God is good to me God is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me, to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to meGod is good to me',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIcon(
                icon: Icons.remove,
                backgroungColor: AppColors.mainColor,
                iconColor: Colors.white,
              ),
              AppIcon(
                icon: Icons.add,
                backgroungColor: AppColors.mainColor,
                iconColor: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
