import 'package:dio/dio.dart';
import 'package:ecommerce_full/models/product-details.model.dart';
import 'package:ecommerce_full/models/product-list-item.model.dart';
import 'package:ecommerce_full/settings.dart';

class ProductRepository {
  Future<List<ProductListItemModel>> getAll() async {
    final url = '${Settings.apiUrl}products';

    Response response = await Dio().get(url);
    return (response.data as List)
        .map((r) => ProductListItemModel.fromJson(r))
        .toList();
  }

  Future<List<ProductListItemModel>> getByCategory(String category) async {
    final tagId = category.replaceAll(RegExp(r"[^0-9]"), '');

    final url = '${Settings.apiUrl}categories/$tagId/products';

    Response response = await Dio().get(url);
    return (response.data as List)
        .map((r) => ProductListItemModel.fromJson(r))
        .toList();
  }

  Future<ProductDetailsModel> getById(String id) async {
    final url = '${Settings.apiUrl}products/$id';

    Response response = await Dio().get(url);
    return ProductDetailsModel.fromJson(response.data);
  }
}
