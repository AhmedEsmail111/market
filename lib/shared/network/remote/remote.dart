import 'package:dio/dio.dart';
import 'package:shop_app/shared/constants/api_constant.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      if (token != null) 'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      if (token != null) 'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.post(url, data: data, queryParameters: query);
  }

  static Future<Response> putData({
    required url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      if (token != null) 'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.put(url, data: data);
  }

  static Future<Response> patchData({
    required url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      if (token != null) 'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.patch(url, data: data);
  }

  static Future<Response> deleteData({
    required url,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      if (token != null) 'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.delete(url, data: data);
  }
}
