import 'package:ecommerce_full/models/category-list-item.model.dart';
import 'package:ecommerce_full/models/product-list-item.model.dart';
import 'package:ecommerce_full/repositories/category.repository.dart';
import 'package:ecommerce_full/repositories/product.repository.dart';
import 'package:flutter/material.dart';

class HomeBloc extends ChangeNotifier {
  final categoryRepository = CategoryRepository();
  final productRepository = ProductRepository();

  List<ProductListItemModel> products;
  List<CategoryListItemModel> categories;
  String selectedCategory = 'all';
  String selectedCategoryTitle = 'all';

  HomeBloc() {
    getCategories();
  }

  getCategories() {
    categoryRepository.getAll().then((data) {
      this.categories = data;
      changeCategory(categories[0].title, categories[0].tag);
      notifyListeners();
    });
  }

  getProductsByCategory() {
    productRepository.getByCategory(selectedCategory).then((data) {
      this.products = data;
      notifyListeners();
    });
  }

  changeCategory(String title, String tag) {
    selectedCategory = tag;
    selectedCategoryTitle = title;
    _clearProducts();
    getProductsByCategory();
  }

  _clearProducts() {
    this.products = null;
    notifyListeners();
  }
}
