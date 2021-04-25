import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_full/models/cart-item.model.dart';
import 'package:ecommerce_full/models/user.model.dart';

class CartRepository {

  Future<List<CartItemModel>> get() async{

  }

  Future<void> save( String userId, List<CartItemModel> cart) async {
    String teste = userId;

    String issoeumteste = "";
  }

  Future<void> clear() async {

  }
}