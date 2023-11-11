import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/common_methods.dart';

String? token;

enum ResponseState {
  sleep,
  offline,
  loading,
  pagination,
  complete,
  error,
  unauthorized,
}

class ApiResponse {
  ResponseState state;

  dynamic data;
  ApiResponse({
    required this.state,
    required this.data,
  });
}

class ApiHelper {
  static ApiHelper? _instance;

  ApiHelper._();

  static ApiHelper get instance {
    _instance ??= ApiHelper._();

    return _instance!;
  }

  final Dio _dio = Dio()
    ..interceptors.addAll(kDebugMode
        ? [
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: false,
              compact: false,
              error: true,
              request: true,
            ),
          ]
        : []);

  Options _options(
    Map<String, String>? headers,
    bool hasToken,
  ) {
    return Options(
      contentType: 'application/json',
      followRedirects: false,
      validateStatus: (status) {
        return true;
      },
      headers: {
        'Accept': 'application/json',
        'Authorization':
            'V2YpbGfGAGaT37cG76lN5k7EhyzvPNITnwYBy2FnrrnUOzH8PuxjQlFr',
        ...?headers,
      },
    );
  }

  Map<String, String> _offlineMessage() {
    return {
      'message': "Make sure you are connected to the internet",
    };
  }

  Map<String, String> _errorMessage() {
    return {
      'message': "An error occurred",
    };
  }

  Future<ApiResponse> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    void Function()? onFinish,
    void Function(int, int)? onReceiveProgress,
    bool hasToken = true,
  }) async {
    ApiResponse responseJson;
    if (await CommonMethods.hasConnection() == false) {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }

    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: _options(headers, hasToken),
        onReceiveProgress: onReceiveProgress,
      );
      responseJson = _buildResponse(response);
      Future.delayed(Duration.zero, onFinish);
    } on DioException {
      responseJson = ApiResponse(
        state: ResponseState.error,
        data: _errorMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
    } on SocketException {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    return responseJson;
  }

  Future<ApiResponse> download(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Map<String, String>? headers,
    void Function()? onFinish,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    bool hasToken = true,
  }) async {
    ApiResponse responseJson;

    if (await CommonMethods.hasConnection() == false) {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    final fileName = path.basename(url);
    final savePath = await _getFilePath(fileName);
    try {
      final response = await _dio.download(
        url,
        savePath,
        queryParameters: queryParameters,
        data: body,
        options: _options(headers, hasToken),
        onReceiveProgress: onReceiveProgress,
      );
      responseJson = _buildResponse(response);
      Future.delayed(Duration.zero, onFinish);
    } on DioException {
      responseJson = ApiResponse(
        state: ResponseState.error,
        data: _errorMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
    } on SocketException {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        data: _offlineMessage(),
      );
      Future.delayed(Duration.zero, onFinish);
      return responseJson;
    }
    return responseJson;
  }

  Future<String> _getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir;

    if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      dir = Directory('/storage/emulated/0/Download');
      if (!await dir.exists()) {
        dir = (await getExternalStorageDirectories(
          type: StorageDirectory.downloads,
        ))!
            .first;
      }
    }
    path = '${dir.path}/$uniqueFileName';
    return path;
  }

  ApiResponse _buildResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.complete,
          data: responseJson,
        );
      case 201:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.complete,
          data: responseJson,
        );
      case 400:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.error,
          data: responseJson,
        );
      case 401:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.unauthorized,
          data: responseJson,
        );
      case 422:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.error,
          data: responseJson,
        );
      case 403:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.error,
          data: responseJson,
        );
      case 500:
      default:
        var responseJson = response.data;
        return ApiResponse(
          state: ResponseState.error,
          data: responseJson,
        );
    }
  }
}
