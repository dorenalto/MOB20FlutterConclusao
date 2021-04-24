import 'package:dio/dio.dart';
import 'package:ecommerce_full/models/product-details.model.dart';
import 'package:ecommerce_full/models/product-list-item.model.dart';
import 'package:ecommerce_full/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository {
  Future<List<ProductListItemModel>> getAll() async {
    final url = '${Settings.apiUrl}products';

    Response response = await Dio().get(url);
    return (response.data as List)
        .map((r) => ProductListItemModel.fromJson(r))
        .toList();
  }

  //Busca produtos por categoria
  Future<List<ProductListItemModel>> getByCategory(String category) async {
    final tagId = category.replaceAll(RegExp(r"[^0-9]"), '');

    var response =  <ProductListItemModel>[];

    await Firestore.instance.collection('products')
        .where('tag', isEqualTo: tagId)
        .getDocuments().then((event) {
      if(event.documents.isNotEmpty){
        event.documents.forEach((doc) {
          var product = ProductListItemModel(
            title: doc.data["title"],
            price: double.parse(doc.data["price"].toString()),
            brand: doc.data["brand"],
            tag: doc.data["tag"],
            image: doc.data["image"],
            id: doc.documentID
          );

          response.add(product);
        });
      }
    }).catchError((erro) => print("Firebase error $erro"));

    return response;
  }

  //Busca produto por id para mostrar na tela de detalhes
  Future<ProductDetailsModel> getById(String id) async {

    var response;

    await Firestore.instance.collection('products').document(id)
        .get().then((event) {
      if(event.exists){

          var product = ProductDetailsModel(
              title: event.data["title"],
              price: double.parse(event.data["price"].toString()),
              brand: event.data["brand"],
              tag: event.data["tag"],
              images: new List<String>.from(event.data["images"]),
              description: event.data["description"],
              id: event.documentID
          );

          response = product;
      }
    }).catchError((erro) => print("Firebase error $erro"));

    return response;
  }
}
