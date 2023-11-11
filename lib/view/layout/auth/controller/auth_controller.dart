import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../helper/storage/shared_methods.dart';
import '../../../../helper/utils/common_methods.dart';
import '../../../../model/user_model.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection('users');

  UserModel? _user;
  UserModel? get user => _user;

  void initial() async {
    _user = null;
    _user = await SharedMethods.read();
    notifyListeners();
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    CommonMethods.loading();
    try {
      final inputUser = UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
      );

      final users =
          await _userCollection.where("phone", isEqualTo: phone).limit(1).get();
      final check = users.docs
          .map((e) => UserModel.fromJson(e.data()))
          .toList()
          .isNotEmpty;

      if (check) {
        throw FirebaseAuthException(
          code: '',
          message: 'The phone is used before',
        );
      }

      await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        _userCollection.add(inputUser.toJson());
        SharedMethods.save(inputUser);
        _user = inputUser;
        notifyListeners();
        CommonMethods.loadingOff();
        onSuccess.call();
      });
    } on FirebaseAuthException catch (e) {
      CommonMethods.loadingOff();
      CommonMethods.showToast(
        message: e.message ?? "",
        color: Colors.redAccent,
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    CommonMethods.loading();
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        final users = await _userCollection
            .where("email", isEqualTo: email)
            .limit(1)
            .get();
        final singleUser = users.docs
            .map((e) => UserModel.fromJson(e.data()))
            .toList()
            .firstOrNull;
        SharedMethods.save(
          singleUser ?? UserModel(email: email),
        );
        _user = singleUser ?? UserModel(email: email);
        notifyListeners();
        CommonMethods.loadingOff();
        onSuccess.call();
      });
    } on FirebaseAuthException catch (e) {
      CommonMethods.loadingOff();
      CommonMethods.showToast(
        message: e.message ?? "",
        color: Colors.redAccent,
      );
    }
  }

  Future<void> logout(VoidCallback onEnd) async {
    CommonMethods.loading();
    await SharedMethods.remove();
    await _firebaseAuth.signOut();
    CommonMethods.loadingOff();
    onEnd.call();
  }
}
