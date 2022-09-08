import 'package:client/helpers/headers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Dio dio = Dio();

final flutterSecureStorage =  new FlutterSecureStorage();

//BaseOptions
Options dioOptions =  Options(
    receiveTimeout: 10 * 1000,
    receiveDataWhenStatusError: true,
    sendTimeout: 10 * 1000,
    headers: {
      'Content-Type': "application/json",
      "Access-Control-Allow-Origin": "*",
     
    });
