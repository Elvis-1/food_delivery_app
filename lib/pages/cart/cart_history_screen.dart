import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/app_icon.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    // print(getCartHistoryList[0]);
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      print(i.toString() + getCartHistoryList[i].time!);
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    print(cartItemsPerOrder.toString() + ' this is cartItemPerOrder');

    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList(); // 3,2,3

    var listCounter = 0;
    print(itemsPerOrder.toString() + ' yes it got here');

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.only(top: 45),
            color: AppColors.mainColor,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'Cart History',
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(
                top: Dimension.width20,
                right: Dimension.width20,
                left: Dimension.width20),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(children: [
                if (itemsPerOrder.isNotEmpty)
                  for (int i = 0; i <= itemsPerOrder.length; i++)
                    Container(
                      height: 120,
                      margin: EdgeInsets.only(bottom: Dimension.height20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (() {
                            //  yyyy-MM-dd HH:mm:ss -- this is the format his date returned, yours may not returned this. Its a string
                            DateTime parseDate =
                                DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .parse(getCartHistoryList[i].time!);
                            var inputDate =
                                DateTime.parse(parseDate.toString());
                            var outPutFormat = DateFormat("MM/dd/yyy hh:mm a");
                            var outPutDate = outPutFormat.format(inputDate);
                            return Text(outPutDate);

                            return const Text('Date');
                          }()),
                          SizedBox(
                            height: Dimension.height10,
                          ),
                          Row(
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                children:
                                    List.generate(itemsPerOrder[i], (index) {
                                  if (listCounter < getCartHistoryList.length) {
                                    listCounter++;
                                  }
                                  return index <= 2
                                      ? Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimension.radius15 / 2),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/image/food0.png'
                                                      // AppConstants
                                                      //           .RECOMMENDED_FOOD_IMAGE +
                                                      //       getCartHistoryList[listCounter-1]
                                                      //           .img!

                                                      ))),
                                        )
                                      : Container();
                                }),
                              )
                            ],
                          ),
                          Container(
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SmallText(
                                  text: 'Total',
                                  color: AppColors.titleColor,
                                ),
                                BigText(
                                  text: itemsPerOrder[i].toString() + "Items",
                                  color: AppColors.titleColor,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimension.width10,
                                      vertical: Dimension.height10 / 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimension.radius15 / 3),
                                    border: Border.all(
                                        width: 1, color: AppColors.mainColor),
                                  ),
                                  child: SmallText(
                                      text: 'one more',
                                      color: AppColors.mainColor),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
              ]),
            ),
          ))
        ],
      ),
    );
  }
}
