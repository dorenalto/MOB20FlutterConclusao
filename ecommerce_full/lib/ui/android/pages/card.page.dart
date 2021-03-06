import 'package:ecommerce_full/blocs/theme.bloc.dart';
import 'package:ecommerce_full/blocs/user.bloc.dart';
import 'package:ecommerce_full/themes/dark-pink.theme.dart';
import 'package:ecommerce_full/ui/android/pages/purchase.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card_brazilian/credit_card_form.dart';
import 'package:flutter_credit_card_brazilian/credit_card_model.dart';
import 'package:flutter_credit_card_brazilian/flutter_credit_card.dart';
import 'package:ecommerce_full/blocs/cart.bloc.dart';
import 'package:provider/provider.dart';

void main() => runApp(CardPage());

class CardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CardPageState();
  }
}

class CardPageState extends State<CardPage> {
  String cardNumber = '';
  String cardName = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final CartBloc cartBloc = Provider.of<CartBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagamento"),
      ),
      body: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardName: (String value) {
                  print(value);
                },
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    textColor: Theme.of(context).primaryColor,
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  cartBloc.clearBase(userBloc.user);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PurchasePage()));
                },
                child: Text(
                  'Confirmar',
                ),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
