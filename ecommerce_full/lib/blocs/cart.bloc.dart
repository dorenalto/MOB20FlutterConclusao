import 'package:ecommerce_full/models/cart-item.model.dart';
import 'package:flutter/material.dart';

class CartBloc extends ChangeNotifier {
  var cart = List<CartItemModel>();
  double total = 0;

  List<CartItemModel> get() {
    return cart;
  }

  add(CartItemModel item) {
    cart.add(item);
    calculateTotal();
  }

  remove(CartItemModel item) {
    cart.removeWhere((c) => c.id == item.id);
    calculateTotal();
  }

  bool itemInCart(CartItemModel item) {
    return cart.where((c) => c.id == item.id).isNotEmpty;
  }

  increase(CartItemModel item) {
    if (item.quantity < 10) {
      item.quantity++;
      calculateTotal();
    }
  }

  decrease(CartItemModel item) {
    if (item.quantity > 0) {
      item.quantity--;
      calculateTotal();
    }
  }

  clear(){
    cart.clear();
    calculateTotal();
    notifyListeners();
  }

  calculateTotal() {
    total = 0;
    cart.forEach((c) {
      total += c.price * c.quantity;
    });

    notifyListeners();
  }

  save(){

  }
}
