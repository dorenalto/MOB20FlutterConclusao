import 'package:ecommerce_full/blocs/home.bloc.dart';
import 'package:ecommerce_full/ui/shared/widgets/category/category-list.widget.dart';
import 'package:ecommerce_full/ui/shared/widgets/product/product-list.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = Provider.of<HomeBloc>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'Categorias',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 10,
            ),
            CategoryList(
              categories: homeBloc.categories,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Mais Vendidos',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 10,
            ),
            ProductList(
              products: homeBloc.products,
            ),
          ],
        ),
      ),
    );
  }
}
