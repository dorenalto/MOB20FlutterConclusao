import 'package:ecommerce_full/blocs/theme.bloc.dart';
import 'package:ecommerce_full/blocs/user.bloc.dart';
import 'package:ecommerce_full/settings.dart';
import 'package:ecommerce_full/ui/android/pages/tabs.page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserBloc _userBloc = Provider.of<UserBloc>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Compra Finalizada'),
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TabsPage(0)));
            },
          )
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Obrigado ${_userBloc.user.name}!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              'Compra efetuada com sucesso!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20
              ),
            ),
            SizedBox(
              height: 60,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TabsPage(0)));
              },
              child: Text(
                'Voltar para a loja',
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
