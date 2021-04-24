import 'package:ecommerce_full/blocs/cart.bloc.dart';
import 'package:ecommerce_full/models/cart-item.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final CartItemModel item;
  CartBloc _cartBloc;

  CartItem({
    @required this.item,
  });

  @override
  Widget build(BuildContext context) {
    _cartBloc = Provider.of<CartBloc>(context);
    final _priceFormatter = NumberFormat('#,##0.00', 'pt_BR');
    return Container(
      height: 120,
      margin: EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.all(10),
            child: Image.network(
              item.image,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child:
                Text(item.title,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                ),
                Text(
                  'R\$${_priceFormatter.format(item.price)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'R\$${_priceFormatter.format(item.price * item.quantity)}'),
                Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: FlatButton(
                          child: Text('-'),
                          onPressed: () {
                            if (item.quantity == 1) {
                              _showAlertDialog(context, item);
                            } else {
                              _cartBloc.decrease(item);
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(item.quantity.toString()),
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: FlatButton(
                          child: Text('+'),
                          onPressed: () {
                            _cartBloc.increase(item);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showAlertDialog(BuildContext context, CartItemModel item) {
    AlertDialog alert = AlertDialog(
      content: Container(
        width: 200,
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Deseja remover ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: item.title,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' do carrinho?'),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: () {
                      _hideAlertDialog(context);
                    },
                    child: Text(
                      'NÃO',
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _cartBloc.remove(item);
                      _hideAlertDialog(context);
                    },
                    child: Text(
                      'SIM',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _hideAlertDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
