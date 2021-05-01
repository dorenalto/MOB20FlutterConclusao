import 'package:ecommerce_full/blocs/cart.bloc.dart';
import 'package:ecommerce_full/blocs/user.bloc.dart';
import 'package:ecommerce_full/ui/android/pages/settings.page.dart';
import 'package:ecommerce_full/ui/android/pages/tabs.page.dart';
import 'package:ecommerce_full/ui/shared/widgets/account/authenticated-user-card.widget.dart';
import 'package:ecommerce_full/ui/shared/widgets/account/unauthenticated-user-card.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TabsPage(0)));
          },
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: userBloc.user == null
          ? UnautheticatedUserCard()
          : AuthenticatedUser(),
    );
  }
}
