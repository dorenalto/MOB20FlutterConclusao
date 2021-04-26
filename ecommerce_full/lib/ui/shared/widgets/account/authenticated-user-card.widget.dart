import 'package:ecommerce_full/blocs/user.bloc.dart';
import 'package:ecommerce_full/blocs/cart.bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticatedUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final UserBloc _userBloc = Provider.of<UserBloc>(context, listen: false);
    final CartBloc _cartBloc = Provider.of<CartBloc>(context, listen: false);
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(_userBloc.user.image),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(200),
                  color: Theme.of(context).primaryColor,
                  border: Border.all(
                    width: 4,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Bem-vindo, ${_userBloc.user.name}'),
            FlatButton(
              onPressed: () {
                _userBloc.logout();
                _cartBloc.clear();
              } ,
              child: Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
