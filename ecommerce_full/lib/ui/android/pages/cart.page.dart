import 'package:ecommerce_full/blocs/cart.bloc.dart';
import 'package:ecommerce_full/models/cart-item.model.dart';
import 'package:ecommerce_full/ui/shared/widgets/cart/cart-item.widget.dart';
import 'package:ecommerce_full/ui/shared/widgets/shared/loader.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  CartBloc cartBloc;
  final price = NumberFormat('#,##0.00', 'pt_BR');
  List<CartItemModel> items = List<CartItemModel>();

  @override
  Widget build(BuildContext context) {
    cartBloc = Provider.of<CartBloc>(context);
    items = cartBloc.cart;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          children: [
            Expanded(
              child: Loader(
                object: cartBloc.cart,
                callback: _list,
              ),
            ),
            Container(
              height: 80,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: () {},
                    child: Text('Salvar Carrinho'),
                    color: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text('Checkout'),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'R\$ ${price.format(cartBloc.total)}',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: Key(item.id),
          child: CartItem(
            item: item,
          ),
          onDismissed: (direction) {
            cartBloc.remove(item);
          },
          background: Container(
            color: Colors.red.withOpacity(0.1),
          ),
        );
      },
    );
  }
}
