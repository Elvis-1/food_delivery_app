import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/pages/address/widgets/location_dialogue_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAdress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({
    Key? key,
    required this.fromSignUp,
    required this.fromAdress,
    required this.googleMapController,
  }) : super(key: key);

  @override
  State<PickAddressMap> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PickAddressMap> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.8987, -122.8787);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(
                Get.find<LocationController>().getAddress['longitude']));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
            child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    Get.find<LocationController>()
                        .updatePosition(_cameraPosition, false);
                  },
                  onMapCreated: (GoogleMapController mapController) {
                    _mapController = mapController;
                  },
                ),
                Center(
                    child: !locationController.loading
                        ? Image.asset(
                            'assets/image/pick_marker.png',
                            height: 50,
                            width: 50,
                          )
                        : CircularProgressIndicator()),
                Positioned(
                  top: Dimension.height25,
                  left: Dimension.width20,
                  right: Dimension.width20,
                  child: InkWell(
                    onTap: () {
                      Get.dialog(
                          LocationDialogue(mapController: _mapController));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimension.width10),
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimension.radius20 / 2)),
                      child: Row(children: [
                        Icon(
                          Icons.location_on,
                          size: 25,
                          color: AppColors.yellowColor,
                        ),
                        Expanded(
                          child: Text(
                            '${locationController.pickPlacemark.name ?? "nothing yet"}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimension.font16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 80,
                    right: Dimension.width20,
                    left: Dimension.width20,
                    child: locationController.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                            buttonText: locationController.inZone
                                ? widget.fromAdress
                                    ? 'pick An Address'
                                    : 'pick A location'
                                : 'Service is not available in your area',
                            onPressed: (locationController.buttonDisabled ||
                                    locationController.loading)
                                ? null
                                : () {
                                    if (locationController
                                                .pickPosition.latitude !=
                                            0 &&
                                        locationController.pickPlacemark.name !=
                                            null) {
                                      if (widget.fromAdress) {
                                        if (widget.googleMapController !=
                                            null) {
                                          widget.googleMapController!.moveCamera(
                                              CameraUpdate.newCameraPosition(
                                                  CameraPosition(
                                                      target: LatLng(
                                                          locationController
                                                              .pickPosition
                                                              .latitude,
                                                          locationController
                                                              .pickPosition
                                                              .longitude))));
                                          locationController
                                              .setAddAddressData();
                                        }
                                        Get.toNamed(
                                            RouteHelper.getAddAddressScreen());
                                      }
                                    } else {
                                      print('you know it won\'t work');
                                    }
                                  },
                          ))
              ],
            ),
          ),
        )),
      );
    });
  }
}
