import 'package:ecommerce_full/models/product-list-item.model.dart';
import 'package:ecommerce_full/ui/shared/widgets/product/product-card.widget.dart';
import 'package:ecommerce_full/ui/shared/widgets/shared/loader.widget.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final List<ProductListItemModel> products;

  ProductList({
    @required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      child: Loader(
        object: products,
        callback: _list,
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final _product = products[index];
        return Padding(
          padding: EdgeInsets.all(5),
          child: ProductCard(product: _product),
        );
      },
    );
  }
}
