import 'package:dio/dio.dart';

abstract class ApiExceptions {
  final String errorMessage;
  const ApiExceptions(this.errorMessage);
}

class ServerExceptins extends ApiExceptions {
  ServerExceptins(super.errorMessage);

  factory ServerExceptins.fromDioException(DioException dioException) {
    switch(dioException.type) {
      
      case DioExceptionType.connectionTimeout:
        return ServerExceptins('انتهت مهلة الاتصال مع الخادم!');
      case DioExceptionType.sendTimeout:
        return ServerExceptins('هناك مشكلة اتصال مع الخادم!');
      case DioExceptionType.receiveTimeout:
        return ServerExceptins('هناك مشكلة اتصال مع الخادم!');
      case DioExceptionType.badCertificate:
        return ServerExceptins('هناك مشكلة اتصال مع الخادم!');
      case DioExceptionType.badResponse:
        return ServerExceptins('Server error!');
      case DioExceptionType.cancel:
        return ServerExceptins('تم رفع طلب البيانات من الخادم!');
      case DioExceptionType.connectionError:
        return ServerExceptins('هناك مشكلة اتصال مع الخادم!');
      case DioExceptionType.unknown:
        if(dioException.message!.contains('SocketException')){
          return ServerExceptins('لا يوجد اتصال بالانترنت');
        }
      return ServerExceptins('حدث خطأ غير متوقع!');
    }

  }
  factory ServerExceptins.fromResponse (int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerExceptins(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerExceptins('Your request not found, Please try again later!');
    } else if (statusCode == 500) {
      return ServerExceptins('Internal server error, Please try again later!');
    } else {
      return ServerExceptins('Opps, something went wrong :(');
    }
  }
}