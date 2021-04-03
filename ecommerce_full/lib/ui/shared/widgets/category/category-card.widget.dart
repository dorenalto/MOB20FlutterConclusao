import 'package:ecommerce_full/blocs/home.bloc.dart';
import 'package:ecommerce_full/models/category-list-item.model.dart';
import 'package:ecommerce_full/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  final CategoryListItemModel category;

  CategoryCard({
    @required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final HomeBloc _homeBloc = Provider.of<HomeBloc>(context);
    return Container(
      margin: EdgeInsets.all(5),
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: category.tag == _homeBloc.selectedCategory
            ? Theme.of(context).primaryColor.withOpacity(0.3)
            : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(70),
      ),
      child: FlatButton(
        child: Image.asset(
          'assets/categories/${Settings.theme}/${category.tag}.png',
          fit: BoxFit.cover,
        ),
        onPressed: () {
          _homeBloc.changeCategory(category.tag);
        },
      ),
    );
  }
}
