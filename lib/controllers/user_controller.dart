import 'package:food_delivery/data/repository/user_repo.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:food_delivery/models/user_model.dart';

import 'package:get/get.dart';

import '../models/user_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  UserInfoModel? _userInfoModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserInfoModel? get userInfoModel => _userInfoModel;

  Future<ResponseModel> getUserInfo() async {
    _isLoading = false;
    //_isLoading = true;
    // update();
    Response response = await userRepo.getUserInfo();
    //print('response ' + response.body.toString());
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      // print('got here');
      _userInfoModel = UserInfoModel.fromJson(response.body);

      _isLoading = false;
      update();
      responseModel = ResponseModel(true, 'Successful');
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }
}
