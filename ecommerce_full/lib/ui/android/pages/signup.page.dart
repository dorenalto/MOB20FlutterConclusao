import 'dart:io';

import 'package:ecommerce_full/blocs/user.bloc.dart';
import 'package:ecommerce_full/models/create-user.model.dart';
import 'package:ecommerce_full/ui/shared/validators/custom.validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isButtonEnabled = false;

  CreateUserModel user = CreateUserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
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
                  labelText: 'Nome',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
                validator: (value) {
                  return value.isEmpty ? 'Nome Inválido' : null;
                },
                onSaved: (newValue) {
                  user.name = newValue;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
                validator: (value) {
                  return CustomValidators.isEmail(value);
                },
                onSaved: (newValue) {
                  user.email = newValue;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
                validator: (value) {
                  return value.isEmpty ? 'Usuário Inválido' : null;
                },
                onSaved: (newValue) {
                  user.username = newValue;
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
                    fontSize: 16.0,
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

                  if (value.length < 6) {
                    return 'A senha deve ter, no mínimo, 6 caracteres';
                  }

                  return null;
                },
                onSaved: (newValue) {
                  user.password = newValue;
                },
              ),
              FlatButton(
                onPressed: () => _tiraFoto(),
                child: Text('Tirar foto',
                style: TextStyle(
                  fontSize: 20,
                ),
                ),
                color: Theme.of(context).primaryColor,
              ),
              FlatButton(
                onPressed: _isButtonEnabled
                    ? () {
                        final _isFormValid = _formKey.currentState.validate();
                        if (_isFormValid) {
                          _setButtonEnabled(!_isFormValid);
                          _create(context, user);
                        } else {
                          _setButtonEnabled(_isFormValid);
                        }
                      }
                    : null,
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _create(BuildContext context, CreateUserModel user) async {
    _showAlertDialog(context);

    final UserBloc userBloc = Provider.of<UserBloc>(context, listen: false);
    final createdUser = await userBloc.create(user);

    _setButtonEnabled(true);
    _hideAlertDialog(context);

    if (createdUser != null) {
      Navigator.pop(context);
      final snackbar = SnackBar(content: Text('Bem-vindo! Autentique-se'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      final snackbar =
          SnackBar(content: Text('Não foi possível realizar seu cadastro'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  _setButtonEnabled(bool isEnabled) {
    setState(() {
      _isButtonEnabled = isEnabled;
    });
  }

  _shouldEnableButton() {
    final _isButtonEnabled = user.email.isNotEmpty &&
        user.name.isNotEmpty &&
        user.username.isNotEmpty &&
        user.password.isNotEmpty;
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

  Future<void> _tiraFoto() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    final Directory systemTempDir = Directory.systemTemp;

    user.image = await FlutterImageCompress.compressAndGetFile(
      img.absolute.path, '${systemTempDir.path}/${user.username}.jpeg',
      quality: 80,
    );
    }
  }

