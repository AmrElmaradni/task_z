import 'package:flutter/material.dart';

import '../../../../helper/networking/api_helper.dart';
import '../../../../helper/networking/urls.dart';
import '../../../../model/wallpaper_model.dart';

class HomeController extends ChangeNotifier {
  void initial() {
    _wallpapersResponse = ApiResponse(
      data: null,
      state: ResponseState.sleep,
    );
    _wallpapers = [];
    _wallpapersPage = 1;
    _wallpapersHasPagination = true;
    notifyListeners();
  }

  ApiResponse _wallpapersResponse = ApiResponse(
    data: null,
    state: ResponseState.sleep,
  );
  ApiResponse get wallpapersResponse => _wallpapersResponse;

  List<WallpaperModel> _wallpapers = [];
  List<WallpaperModel> get wallpapers => _wallpapers;

  int _wallpapersPage = 1;

  bool _wallpapersHasPagination = true;
  bool get wallpapersHasPagination => _wallpapersHasPagination;

  Future<void> getWallpapers() async {
    if (_wallpapersPage == 1) {
      _wallpapersResponse = ApiResponse(
        data: null,
        state: ResponseState.loading,
      );
      _wallpapers = [];
      notifyListeners();
    } else {
      _wallpapersResponse = ApiResponse(
        data: null,
        state: ResponseState.pagination,
      );
    }
    _wallpapersResponse =
        await ApiHelper.instance.get(Urls.curated, queryParameters: {
      'page': _wallpapersPage,
      'per_page': 80,
    });
    notifyListeners();

    if (_wallpapersResponse.state == ResponseState.complete) {
      Iterable iterable = _wallpapersResponse.data['photos'];
      final data = _wallpapersResponse.data as Map<String, dynamic>;
      if (data.containsKey('next_page')) {
        _wallpapersPage++;
        _wallpapersHasPagination = true;
        notifyListeners();
      } else {
        _wallpapersHasPagination = false;
        notifyListeners();
      }
      _wallpapers
          .addAll(iterable.map((e) => WallpaperModel.fromJson(e)).toList());
      notifyListeners();
    }
  }
}
