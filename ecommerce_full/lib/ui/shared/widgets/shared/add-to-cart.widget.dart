import 'package:ecommerce_full/blocs/cart.bloc.dart';
import 'package:ecommerce_full/blocs/user.bloc.dart';
import 'package:ecommerce_full/models/cart-item.model.dart';
import 'package:ecommerce_full/models/product-list-item.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatelessWidget {
  final ProductListItemModel product;

  AddToCart({
    @required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final CartBloc _cartBloc = Provider.of<CartBloc>(context);

    var cartItem = CartItemModel(
      id: product.id,
      price: product.price,
      image: product.image,
      quantity: 1,
      title: product.title,
    );

    if (!_cartBloc.itemInCart(cartItem)) {
      return Container(
        width: 80,
        height: 40,
        child: FlatButton(
          color: Theme.of(context).primaryColor,
          child: Icon(Icons.add_shopping_cart),
          textColor: Colors.white,
          onPressed: () {
            _cartBloc.add(cartItem);
            final snackbar = SnackBar(
              content: Text('${product.title} adicionado'),
            );
            Scaffold.of(context).showSnackBar(snackbar);
          },
        ),
      );
    } else {
      return Container(
        width: 80,
        height: 40,
        child: FlatButton(
          color: Theme.of(context).primaryColor,
          child: Icon(Icons.remove_shopping_cart),
          textColor: Colors.red,
          onPressed: () {
            _cartBloc.remove(cartItem);
            final snackbar = SnackBar(
              content: Text('${product.title} removido'),
            );
            Scaffold.of(context).showSnackBar(snackbar);
          },
        ),
      );
    }
  }
}
