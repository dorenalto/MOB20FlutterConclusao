import 'package:ecommerce_full/ui/android/pages/login.page.dart';
import 'package:ecommerce_full/ui/android/pages/signup.page.dart';
import 'package:flutter/material.dart';

class UnautheticatedUserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 60,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text('Autentique-se',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupPage(),
                  ),
                );
              },
              child: Text('Ainda não sou cadastrado',
                  style: TextStyle(
                  decoration: TextDecoration.underline,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
