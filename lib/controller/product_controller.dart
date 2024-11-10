import 'dart:developer';

import 'package:api_integration_app/model/product_model.dart';
import 'package:api_integration_app/resource/api_resources.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  Future<List<ProductModel>> getProduct() async {
    try {
      var response = await http.get(Uri.parse(APIRoute().products));
      if (response.statusCode == 200) {
        return productFromJson(response.body);
      } else {
        log(response.body.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }
}
