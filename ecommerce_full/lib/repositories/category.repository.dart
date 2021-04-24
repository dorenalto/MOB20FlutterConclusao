import 'package:dio/dio.dart';
import 'package:ecommerce_full/models/category-list-item.model.dart';
import 'package:ecommerce_full/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepository {

  //Busca categorias do Firebase
  Future<List<CategoryListItemModel>> getAll() async {

    var response =  <CategoryListItemModel>[];

    try {
      await Firestore.instance.collection('categories')
          .getDocuments().then((QuerySnapshot querySnapShot) {
        querySnapShot.documents.forEach((doc) {
          var category = CategoryListItemModel(
              id: doc.data["id"],
              title: doc.data["title"],
              tag: doc.data["tag"]
          );
          response.add(category);
        });
      });
    }catch(erro) {
      print("Firebase error $erro");
    }

    return response;
  }
}
