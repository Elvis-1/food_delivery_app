import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactPersonName = TextEditingController();
  TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(45.8989, -44.8989), zoom: 17);
  late LatLng _initialPosition = LatLng(45.8989, -44.8989);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userInfoModel == '') {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationController>().getAddress["longitute"])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitute"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.userInfoModel != null &&
              _contactPersonName.text.isEmpty) {
            _contactPersonName.text = '${userController.userInfoModel!.name}';
            _contactPersonNumber.text =
                '${userController.userInfoModel!.phone}';

            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text =
                  '${locationController.placemark.name ?? "My address name"}'
                  '${locationController.placemark.locality ?? " locality"}'
                  '${locationController.placemark.postalCode ?? " Postal code"}'
                  '${locationController.placemark.country ?? " Country"}';
              print("address in my view is " + _addressController.text);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: AppColors.mainColor,
                          )),
                      child: Stack(children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: _initialPosition, zoom: 17),
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: false,
                          myLocationEnabled: true,
                          onCameraIdle: () {
                            locationController.updatePosition(
                                _cameraPosition, true);
                          },
                          onCameraMove: ((position) =>
                              _cameraPosition = position),
                          onMapCreated: (GoogleMapController controller) {
                            locationController.setGoogleController(controller);
                          },
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimension.width20, top: Dimension.height20),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                locationController.addressTypeList.length,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () => locationController
                                    .setAddressTypeIndex(index),
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: Dimension.width10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimension.width20,
                                        vertical: Dimension.height10),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimension.radius15),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[200]!,
                                              spreadRadius: 1,
                                              blurRadius: 5)
                                        ]),
                                    child: Icon(
                                      index == 0
                                          ? Icons.home_filled
                                          : index == 1
                                              ? Icons.work
                                              : Icons.location_on,
                                      color:
                                          locationController.addressTypeIndex ==
                                                  index
                                              ? AppColors.mainColor
                                              : Theme.of(context).disabledColor,
                                    )),
                              );
                            })),
                      ),
                    ),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.width20),
                      child: BigText(text: 'Delivering Address'),
                    ),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    AppTextField(
                        hintText: "Your Address",
                        icon: Icons.map,
                        textController: _addressController),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.width20),
                      child: BigText(text: 'Contact person name'),
                    ),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    AppTextField(
                        hintText: "Your Name",
                        icon: Icons.person,
                        textController: _contactPersonName),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.width20),
                      child: BigText(text: 'Contact person number'),
                    ),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    AppTextField(
                        hintText: "Your Numer",
                        icon: Icons.phone,
                        textController: _contactPersonNumber),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimension.bottomHeightBar,
                padding: EdgeInsets.only(
                    top: Dimension.height30,
                    bottom: Dimension.height30,
                    right: Dimension.width20,
                    left: Dimension.width20),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimension.radius20 * 2),
                      topLeft: Radius.circular(Dimension.radius20 * 2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //print(recommendedfood..name);
                        // controller.addItem(recommendedfood);
                        AddressModel _addressModel = AddressModel(
                            addressType: locationController.addressTypeList[
                                locationController.addressTypeIndex],
                            contactPersonName: _contactPersonName.text,
                            contactPersonNumber: _contactPersonNumber.text,
                            address: _addressController.text,
                            latitude:
                                locationController.position.latitude.toString(),
                            longitude: locationController.position.longitude
                                .toString());

                        locationController
                            .addAddress(_addressModel)
                            .then((value) {
                          if (value.isSuccess) {
                            Get.toNamed(RouteHelper.getInitial());
                            Get.snackbar('Address', "Added Successfully");
                          } else {
                            Get.snackbar('Address', "Couldn't save address");
                          }
                        });
                      },
                      child: Container(
                          height: Dimension.height20 * 6,
                          padding: EdgeInsets.only(
                              top: Dimension.height20,
                              bottom: Dimension.height20,
                              right: Dimension.width20,
                              left: Dimension.width20),
                          child: BigText(
                            text: "Save Address",
                            color: Colors.white,
                            size: 20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20),
                          )),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
