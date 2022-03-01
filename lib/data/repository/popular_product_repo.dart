import 'package:food_delivery/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> GetPopularProductList() async {
    return apiClient.getData('end piont url');
  }
}
