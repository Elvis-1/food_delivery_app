import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery/data/api/api_checker.dart';
import 'package:food_delivery/data/repository/auth_repo.dart';
import 'package:food_delivery/data/repository/location_repo.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/address_model.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  Placemark get pickPlacemark => _pickPlacemark;
  Placemark get placemark => _placemark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;

  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;

  List<String> _addressTypeList = ["Home", "Office", "Others"];
  List<String> get addressTypeList => _addressTypeList;

  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  bool _updateAddressData = true;
  bool _changeAddress = true;
/*
for service zone
*/
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /*
whether the user is in service zone or not
  */
  bool _inZone = false;
  bool get inZone => _inZone;

  /*
 for showing and hiding button as the map loads
  */
  bool _buttonDisabled = true;

  bool get buttonDisabled => _buttonDisabled;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  /*
   save the google map suggestions for address
  */

  List<Prediction> _predictionList = [];

  void setGoogleController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();

      try {
        if (fromAddress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        ResponseModel _responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            false);

        /*
if button value is false, then we are in the service area
            */
        _buttonDisabled = _responseModel.isSuccess;
        if (_changeAddress) {
          String _address = await getAddressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));

          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        } else {
          _changeAddress = true;
        }
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
      //  update();
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = "Unknown location found";

    try {
      Response response = await locationRepo.getAddressFromGeocode(latLng);

      if (response.statusCode == 200) {
        _address = response.body['address'];
      } else {
        print('not working');
      }
    } catch (e) {
      print(e.toString());
    }

    /*
    if (response.body['status'] == 'OK') {
      _address = response.body['results'][0]['formatted_address'].toString();
    } else {
      print('error getting response form server');
    }
*/

    update();
    return _address;
  }

  Map<String, dynamic> _getAddress = {};
  Map<String, dynamic> get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    // converting to a map using json decode
    _getAddress = jsonDecode(locationRepo.getUserAddressFromLocalStorage());

    try {
      _addressModel = AddressModel.fromJson(
          jsonDecode(locationRepo.getUserAddressFromLocalStorage()));
    } catch (e) {
      print(e);
    }

    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    ResponseModel responseModel;
    Response response = await locationRepo.addAddress(addressModel);
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body['message'];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      /*
      responseModel = ResponseModel(false, "Not Working");
      */
      responseModel = ResponseModel(false, "Not Working");
      print('Could not send address');
    }

    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    ResponseModel responseModel;
    Response response = await locationRepo.getAddress();

    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];

      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());

    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddressFromLocalStorage();
  }

  setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }

    /*
    we are keeping this incase we want to mock an http request in the future.
    await Future.delayed(const Duration(seconds: 2), () {
      _responseModel = ResponseModel(true, 'success');
      if (markerLoad) {
        _loading = false;
      } else {
        _isLoading = false;
      }
      _inZone = true;
    });
    */
    update();
    Response response = await locationRepo.getZone(lat, lng);
    if (response.statusCode == 200) {
      _inZone = true;
      _responseModel = ResponseModel(true, response.body['message']);
    } else {
      // _inZone = false;
      _inZone = true; // temporally set
      _responseModel = ResponseModel(false, response.statusText!);
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    update();
    // check grimzy library for new Point ( laravel );
    return _responseModel;
  }

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      Response response = await locationRepo.searchLocation(text);
      if (response.statusCode == 200 && response.body['status'] == 'OK') {
        _predictionList = [];
        response.body['predictions'].forEach((prediction) {
          _predictionList.add(Prediction.fromJson(prediction));
        });
      } else {
        ApiChecker.checkerApi(response);
      }
    }

    return _predictionList;
  }

  setLocation(
      String placeID, String address, GoogleMapController mapController) async {
    _loading = true;
    update();
    PlacesDetailsResponse detail;

    Response response = await locationRepo.searchLocation(placeID);
    detail = PlacesDetailsResponse.fromJson(response.body);

    _pickPosition = Position(
        latitude: detail.result.geometry!.location.lat,
        longitude: detail.result.geometry!.location.lng,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speed: 1,
        speedAccuracy: 1);
    _pickPlacemark = Placemark(name: address);
    _changeAddress = false;
    if (!mapController.isNull) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(detail.result.geometry!.location.lat,
              detail.result.geometry!.location.lng),
          zoom: 17)));
    }
    _loading = false;
    update();
  }
}
