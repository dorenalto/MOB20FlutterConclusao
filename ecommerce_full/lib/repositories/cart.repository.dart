import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_full/models/cart-item.model.dart';
import 'package:ecommerce_full/models/user.model.dart';

class CartRepository {

  Future<List<CartItemModel>> get(String userId) async{

    var response =  <CartItemModel>[];

    await Firestore.instance.collection('users').document(userId).collection("cart")
        .getDocuments().then((event) {
      if(event.documents.isNotEmpty){
        event.documents.forEach((doc) {
          var item = CartItemModel(
              title: doc.data["title"],
              price: double.parse(doc.data["price"].toString()),
              quantity: int.parse(doc.data["quantity"].toString()),
              image: doc.data["image"],
              id: doc.documentID
          );

          response.add(item);
        });
      }
    }).catchError((erro) => print("Firebase error $erro"));

    return response;

  }

  Future<void> save( String userId, List<CartItemModel> cart) async {

    cart.forEach((c) {
      try {
        DocumentReference refCartDoc =
        Firestore.instance.collection("users").document(userId).collection("cart").document(c.id);

        refCartDoc.setData({
          'title': c.title,
          'quantity': c.quantity,
          'price': c.price,
          'image': c.image
        });
      }catch(erro){
        print("Firebase error $erro");
      }
    });



  }

  Future<void> clear() async {

  }
}