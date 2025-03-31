import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final _baseUrl = 'https://api.weatherapi.com/v1/';
  final Dio _dio;
  final int limit = 6;
  final apiKey = dotenv.env['API_KEY'];
  ApiService(this._dio,) {
    _dio.options.headers = {

    };
  }
  
  Future<Map<String,dynamic>> get({
    required String endpoint,
  }) async {
    // print('GET: $_baseUrl${Intl.getCurrentLocale()}/$endpoint');
    var response = await _dio.get('$_baseUrl${Intl.getCurrentLocale()}/$endpoint');
    return response.data;
  }
  Future post ({
    required String endpoint,
    Map? data
  }) async{
    var request = await _dio.post('$_baseUrl$endpoint',data: data);
    return request.data;
  }
}