import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_screen.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
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
    var listCounter = 0;
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    // print(getCartHistoryList[0]);
    Map<String, int> cartItemsPerOrder = Map();
    // Widget timeWidget(int index) {
    //   var outPutDate = DateTime.now().toString();
    //   if (index > 0) {
    //     //  yyyy-MM-dd HH:mm:ss -- this is the format his date returned, yours may not returned this. Its a string
    //     DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss')
    //         .parse(getCartHistoryList[listCounter].time!);
    //     var inputDate = DateTime.parse(parseDate.toString());
    //     var outPutFormat = DateFormat("MM/dd/yyy hh:mm a");
    //     outPutDate = outPutFormat.format(inputDate);
    //   }

    //   return Text(outPutDate);
    // }

    for (int i = 0; i < getCartHistoryList.length; i++) {
      // print(i.toString() + getCartHistoryList[i].time!);
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      // this helps us to get the number of items per order
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      // this helps us to get time for items per order
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList(); // 3,2,3

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimension.height20 * 5,
            padding: EdgeInsets.only(top: Dimension.height45),
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
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getCartHistoryList().length > 0
                ? Expanded(
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
                          for (int i = 0; i < itemsPerOrder.length; i++)
                            Container(
                              height: Dimension.height20 * 6,
                              margin:
                                  EdgeInsets.only(bottom: Dimension.height20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  (() {
                                    //  yyyy-MM-dd HH:mm:ss -- this is the format his date returned, yours may not returned this. Its a string
                                    DateTime parseDate =
                                        DateFormat('yyyy-MM-dd HH:mm:ss').parse(
                                            getCartHistoryList[
                                                    /*listCounter*/ i]
                                                .time!);
                                    var inputDate =
                                        DateTime.parse(parseDate.toString());
                                    var outPutFormat =
                                        DateFormat("MM/dd/yyy hh:mm a");
                                    var outPutDate =
                                        outPutFormat.format(inputDate);
                                    return Text(outPutDate);

                                    // return const Text('Date');
                                  }()),
                                  SizedBox(
                                    height: Dimension.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(
                                            itemsPerOrder[i], (index) {
                                          if (listCounter <
                                              getCartHistoryList.length) {
                                            listCounter++;
                                          }
                                          return index <= 2
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  height:
                                                      Dimension.height20 * 4,
                                                  width: Dimension.width20 * 4,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimension
                                                                  .radius15 /
                                                              2),
                                                      image: const DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage('assets/image/food0.png'
                                                              // AppConstants
                                                              //           .RECOMMENDED_FOOD_IMAGE +
                                                              //       getCartHistoryList[listCounter-1]
                                                              //           .img!

                                                              ))),
                                                )
                                              : Container();
                                        }),
                                      ),
                                      Container(
                                        height: Dimension.height20 * 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SmallText(
                                              text: 'Total',
                                              color: AppColors.titleColor,
                                            ),
                                            BigText(
                                              text:
                                                  itemsPerOrder[i].toString() +
                                                      " Items",
                                              color: AppColors.titleColor,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // print("Doing test " +
                                                //     cartOrderTimeToList()[i]
                                                //         .toString());
                                                var orderItem =
                                                    cartOrderTimeToList();
                                                Map<int, CartModel> moreOrder =
                                                    {};

                                                for (int j = 0;
                                                    j <
                                                        getCartHistoryList
                                                            .length;
                                                    j++) {
                                                  if (getCartHistoryList[j]
                                                          .time ==
                                                      orderItem[i]) {
                                                    // print('my cart or product id is ' +
                                                    //     getCartHistoryList[j]
                                                    //         .toString());
                                                    //          print('my cart or product id is ' +
                                                    //     getCartHistoryList[j].product
                                                    //         .toString());
                                                    // print('product info is ' +
                                                    //     jsonEncode(
                                                    //             getCartHistoryList[j])
                                                    //         .toString());
                                                    moreOrder.putIfAbsent(
                                                        getCartHistoryList[j]
                                                            .id!,
                                                        () => CartModel.fromJson(
                                                            jsonDecode(jsonEncode(
                                                                getCartHistoryList[
                                                                    j]))));
                                                  }
                                                }

                                                Get.find<CartController>()
                                                    .setItems = moreOrder;
                                                Get.find<CartController>()
                                                    .addToCartList();

                                                Get.toNamed(
                                                    RouteHelper.getCartPage());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimension.width10,
                                                    vertical:
                                                        Dimension.height10 / 2),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimension.radius15 /
                                                              3),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          AppColors.mainColor),
                                                ),
                                                child: SmallText(
                                                    text: 'one more',
                                                    color: AppColors.mainColor),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                      ]),
                    ),
                  ))
                : Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const NoDataScreen(
                      text: 'You have not added any item so far',
                      imgPath: 'assets/image/empty_box.png',
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
