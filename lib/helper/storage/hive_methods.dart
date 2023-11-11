import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../model/favorite_model.dart';
import '../../view/layout/auth/controller/auth_controller.dart';

class HiveMethods {
  static final _box = Hive.box<FavoriteModel>('favorite');

  static void initial(BuildContext context) {
    final favorite = _box.values
        .where((element) =>
            element.email == context.read<AuthController>().user?.email)
        .firstOrNull;

    if (favorite == null) {
      _box.add(
        FavoriteModel(
          email: context.read<AuthController>().user!.email!,
          favorites: [],
        ),
      );
    }
  }
}
