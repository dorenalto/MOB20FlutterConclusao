import 'package:ecommerce_full/ui/shared/widgets/shared/generic-progress-indicator.widget.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final object;
  final Function callback;

  Loader({
    @required this.object,
    @required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    if (object == null) {
      return Center(
        child: GenericProgressIndicator(),
      );
    }

    if (object.isEmpty) {
      return Center(
        child: Text('Nenhum item encontrado'),
      );
    }

    return callback();
  }
}
