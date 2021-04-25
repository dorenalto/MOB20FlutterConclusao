import 'package:ecommerce_full/blocs/cart.bloc.dart';
import 'package:ecommerce_full/ui/android/pages/account.page.dart';
import 'package:ecommerce_full/ui/android/pages/cart.page.dart';
import 'package:ecommerce_full/ui/android/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  int selectedPage;
  TabsPage(this.selectedPage);

  @override
  Widget build(BuildContext context) {
    final cartBloc = Provider.of<CartBloc>(context);

    return DefaultTabController(
        initialIndex:selectedPage,
        length: 3,
    child: Scaffold(
      body: TabBarView(
        children: [
          HomePage(),
          CartPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: cartBloc.cart.length > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              cartBloc.cart.length.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Icon(Icons.shopping_cart),
            ),
            Tab(
              icon: Icon(
                Icons.perm_identity,
              ),
            ),
          ],
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.black38,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5),
          indicatorColor: Theme.of(context).primaryColor,
        ),
      ),
    ),
    );
  }
}
