import 'package:ecommerce_full/blocs/theme.bloc.dart';
import 'package:ecommerce_full/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  ThemeBloc themeBloc;
  @override
  Widget build(BuildContext context) {
    themeBloc = Provider.of<ThemeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'Tema atual: ${Settings.theme}',
              textAlign: TextAlign.center,
            ),
            FlatButton(
              onPressed: () {
                save('light');
              },
              child: Text('Light'),
            ),
            FlatButton(
              onPressed: () {
                save('dark');
              },
              child: Text('Dark'),
            ),
            FlatButton(
              onPressed: () {
                save('dark-yellow');
              },
              child: Text('Dark Yellow'),
            ),
            FlatButton(
              child: Text('Dark Pink'),
              onPressed: () {
                save('dark-pink');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future save(theme) async {
    var prefs = await SharedPreferences.getInstance();

    var themeWasSaved = await prefs.setString('theme', theme);
    if (themeWasSaved) {
      themeBloc.change(theme);
    }
  }
}
