import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RecommendedFoodRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedFoodRepo({required this.apiClient});

  Future GetRecommendedFoodList() async {
    return apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
