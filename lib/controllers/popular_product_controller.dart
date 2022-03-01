import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> popularProductList = [];

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.GetPopularProductList();
  }
}
