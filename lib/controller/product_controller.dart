import 'dart:developer';

import 'package:api_integration_app/model/product_model.dart';
import 'package:api_integration_app/resource/api_resources.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController
    with StateMixin<List<ProductModel>> {
  @override
  void onInit() {
    super.onInit();
    change([], status: RxStatus.success());
  }

  @override
  void onReady() {
    super.onReady();
    getProduct();
  }

  Future getProduct() async {
    if (status.isLoadingMore) return;
    if (!status.isLoadingMore && value!.isNotEmpty) {
      change(value, status: RxStatus.loadingMore());
    } else {
      change([], status: RxStatus.loading());
    }
    try {
      var response = await http.get(Uri.parse(APIRoute().products));
      if (response.statusCode == 200) {
        value?.addAll(productFromJson(response.body));
        return change(value, status: RxStatus.success());
      } else {
        return change([], status: RxStatus.empty());
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }
}
