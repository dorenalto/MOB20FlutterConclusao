import 'package:ecommerce_full/models/product-details.model.dart';
import 'package:ecommerce_full/repositories/product.repository.dart';
import 'package:ecommerce_full/ui/shared/widgets/shared/generic-progress-indicator.widget.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String id;
  final ProductRepository _productRepository = ProductRepository();

  ProductPage({
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductDetailsModel>(
      future: _productRepository.getById(id),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Aguardando...');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: GenericProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(
                child: Text('Não foi possível obter o produto.'),
              );
            }

            final ProductDetailsModel _productDetail = snapshot.data;
            return _content(_productDetail);
        }
      },
    );
  }

  Widget _content(ProductDetailsModel product) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: product.images.length,
        itemBuilder: (context, index) {
          final _imageUrl = product.images[index];
          return Container(
            width: 200,
            child: Image.network(_imageUrl),
          );
        },
      ),
    );
  }
}
