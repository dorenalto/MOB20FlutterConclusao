import 'package:ecommerce_full/blocs/user.bloc.dart';
import 'package:ecommerce_full/models/authenticate-user.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String username = '';

  String password = '';

  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          onChanged: () {
            _formKey.currentState.save();
            _shouldEnableButton();
          },
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Usuário Inválido';
                  }
                  return null;
                },
                onSaved: (value) {
                  username = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Senha Inválida';
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value;
                },
              ),
              FlatButton(
                onPressed: _isButtonEnabled
                    ? () {
                        final _isFormValid = _formKey.currentState.validate();
                        _setButtonEnabled(_isFormValid);
                        if (_isFormValid) {
                          _setButtonEnabled(!_isFormValid);
                          _authenticate(context);
                        } else {
                          _setButtonEnabled(_isFormValid);
                        }
                      }
                    : null,
                child: Text(
                  'Entrar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _authenticate(BuildContext context) async {
    _showAlertDialog(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context, listen: false);

    var user = await userBloc.authenticate(AuthenticateModel(
      username: username,
      password: password,
    ));

    _hideAlertDialog(context);

    if (user != null) {
      Navigator.pop(context);
      return;
    }

    final snackbar = SnackBar(
      content: Text(
        'Usuário ou senha inválidos',
      ),
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _setButtonEnabled(bool isEnabled) {
    setState(() {
      _isButtonEnabled = isEnabled;
    });
  }

  _shouldEnableButton() {
    final _isButtonEnabled = username.isNotEmpty && password.isNotEmpty;
    _setButtonEnabled(_isButtonEnabled);
  }

  _showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("Carregando..."),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _hideAlertDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
