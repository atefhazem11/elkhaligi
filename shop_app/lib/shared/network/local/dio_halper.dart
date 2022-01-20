import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api//',
          receiveDataWhenStatusError: true,
         // headers: {
         //   'Content-Type': 'application/json'
          //}
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token ,
  }) async
  {
    dio!.options.headers ={
            'Content-Type': 'application/json',
            'lang' : lang ,
            'Authorization' : token??'',
    };
    return await dio!.get(
        url,
        queryParameters: query
    );
  }

  static Future<Response> postData({
    required String url,
     Map<String, dynamic>? data,
    String lang = 'en',
    String? token ,
  }) async
  {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token??'',
      'Content_Type' : 'application/json',
    };

    return dio!.post(
      url,
      data: data,
    );
  }


  static Future<Response> putData({
    required String url,
     Map<String, dynamic>? data,
    String lang = 'en',
    String? token ,
  }) async
  {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token??'',
      'Content_Type' : 'application/json',
    };

    return dio!.put(
      url,
      data: data,
    );
  }
}
