import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ecommerce_full/models/authenticate-user.model.dart';
import 'package:ecommerce_full/models/create-user.model.dart';
import 'package:ecommerce_full/models/user.model.dart';
import 'package:ecommerce_full/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

String firebaseUserUid;

class AccountRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> authenticate(AuthenticateModel model) async {

    var user;

    await Firestore.instance.collection('users')
        .where('username', isEqualTo: model.username)
        .getDocuments().then((event) {
        if(event.documents.isNotEmpty){
          Map<String, dynamic> documentData = event.documents.single.data;
          user = UserModel(
            username: documentData["username"].toString(),
            email: documentData["email"].toString(),
            name: documentData["name"].toString(),
            image: documentData["image"].toString(),
          );
        }
    }).catchError((erro) => print("Firebase error $erro"));

    if(user != null) {
      try {
        AuthResult result =
        await _auth.signInWithEmailAndPassword(
            email: user.email, password: model.password);
        final FirebaseUser fUser = result.user;

        user.id = fUser.uid;

        return user;
      } catch (erro) {
          print("Firebase error $erro");
        return null;
      }
    } else {
      return null;
    }
  }

  Future<UserModel> create(CreateUserModel model) async {

    await Firestore.instance.collection('users')
        .where('username', isEqualTo: model.username)
        .getDocuments().then((event) {
      if(event.documents.isNotEmpty){
            return null;
      }
    }).catchError((erro) => print("Firebase error $erro"));

    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: model.email, password: model.password);
      final FirebaseUser fUser = result.user;

      String imgUser;

      if(model.image != null){
        imgUser = await uploadFirebaseStorage(model.image);
      }

      final user = UserModel(
          id: fUser.uid,
          name: model.name,
          email: model.email,
          username: model.username,
          image: imgUser
      );

      saveUser(user);

      return user;

    } catch(erro){
      print("Firebase error $erro");
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  void saveUser(UserModel user) async {
    if (user != null) {
      firebaseUserUid = user.id;
      DocumentReference refUser =
      Firestore.instance.collection("users").document(firebaseUserUid);
      refUser.setData({
        'name': user.name,
        'email': user.email,
        'username': user.username,
        'image': user.image
      });
    }
  }

  static Future<String> uploadFirebaseStorage(File file) async {
    String fileName = path.basename(file.path);
    final storageRef = FirebaseStorage.instance.ref().child("userImages/$fileName");

    final StorageTaskSnapshot task = await storageRef.putFile(file).onComplete;
    final String urlFoto = await task.ref.getDownloadURL();

    return urlFoto;
  }
}
