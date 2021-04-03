import 'package:ecommerce_full/ui/android/pages/account.page.dart';
import 'package:ecommerce_full/ui/ios/pages/home.page.dart';
import 'package:flutter/cupertino.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Conta',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return HomePage();
              case 1:
                return Container(
                  color: CupertinoColors.activeBlue,
                );
              case 2:
                return AccountPage();
            }
          },
        );
      },
    );
  }
}
