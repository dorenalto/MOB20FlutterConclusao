import 'dart:convert';

import 'package:ecommerce_full/models/cart-item.model.dart';
import 'package:ecommerce_full/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_full/repositories/cart.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBloc extends ChangeNotifier {

  final cartRepository = CartRepository();

  var cart = List<CartItemModel>();
  double total = 0;

  CartBloc(){
    loadCart();
  }

  loadCart() {
    SharedPreferences.getInstance().then((data) {

      var userData = data.getString('user');

      if (userData != null) {
        var json = jsonDecode(userData);
        UserModel user = UserModel.fromJson(json);
        get(user);
        notifyListeners();
      }
    });
  }

  get(UserModel user) {
    cartRepository.get(user.id).then((data) {
      this.cart = data;
      calculateTotal();
      notifyListeners();
    });
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

  save(UserModel user){
    cartRepository.save(user.id, cart);
  }

  clearBase(UserModel user){
    cartRepository.clear(user.id);
    clear();
  }
}
