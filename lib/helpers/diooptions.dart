import 'package:client/helpers/headers.dart';
import 'package:dio/dio.dart';

Dio dio = Dio();


//BaseOptions
Options dioOptions =  Options(
    receiveTimeout: 10 * 1000,
    receiveDataWhenStatusError: true,
    sendTimeout: 10 * 1000,
    headers: {
      'Content-Type': "application/json",
      "Access-Control-Allow-Origin": "*",
     
    });
