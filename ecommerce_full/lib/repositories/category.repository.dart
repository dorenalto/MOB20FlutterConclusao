import 'package:dio/dio.dart';
import 'package:ecommerce_full/models/category-list-item.model.dart';
import 'package:ecommerce_full/settings.dart';

class CategoryRepository {
  Future<List<CategoryListItemModel>> getAll() async {
    final url = '${Settings.apiUrl}categories';

    Response response = await Dio().get(url);
    return (response.data as List)
        .map((r) => CategoryListItemModel.fromJson(r))
        .toList();
  }
}
