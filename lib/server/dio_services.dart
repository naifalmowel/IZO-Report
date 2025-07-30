import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;

class DioClient {
  final Dio dio = Dio(
    BaseOptions(
      receiveTimeout: const Duration(milliseconds: 5000),
      connectTimeout: const Duration(milliseconds: 5000),
      sendTimeout: const Duration(milliseconds: 5000),
      headers: {
        HttpHeaders.accessControlAllowOriginHeader: "*",
        HttpHeaders.accessControlAllowMethodsHeader: "GET,POST,OPTIONS",
        HttpHeaders.accessControlAllowHeadersHeader: "application/json",
      },

      responseType: ResponseType.json,
      baseUrl: 'https://admin.izocloud.com/api',
      // baseUrl: g.Get.find<SharedPreferences>().getString('url') == null
      //     ? ''
      //     : 'http://${g.Get.find<SharedPreferences>().getString('url')}',
      validateStatus: (statusCode) {
        if (statusCode == null) {
          g.Get.snackbar(
            'ERROR',
            'SORRY , NO SERVER CONNECTION !!',
            backgroundColor: Colors.red.withOpacity(0.8),
            borderRadius: 20,
            margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
            icon: const Icon(Icons.warning),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
          );
          return false;
        }
        if (statusCode == 404) {
          return true;
        } else {
          return statusCode >= 200 && statusCode < 300;
        }
      },
    ),
  );

  DioClient() {
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        return handler.next(options);
      }, onResponse: (response, handler) {
        return handler.next(response);
      }, onError: (err, handler) async {
        if (err.response?.statusCode ==
            404) // username or password is not correct .
        {
          handler.next(err);
        }
        return handler.next(err);
      }),
    );
  }

  Future<Response> postDio({
    required String path,
    required Map<String, dynamic> data1,
  }) async {
    final data = await dio.post(path, data: data1);
    return data;
  }

  Future<Response> getDio({
    required String path,
  }) async {
    final data = await dio.get(
      path,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      }),
    );
    return data;
  }
}
