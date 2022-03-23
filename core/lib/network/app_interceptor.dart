import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:core/const/app_config.dart';
import 'package:core/const/app_const.dart';
import 'package:core/network/internet_handler.dart';
import 'package:core/ui/dialog_no_network.dart';

class AppInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var hasInternet = await checkInterAvailable();
    if (hasInternet) {
      options.baseUrl = AppConfig.currentEnviroment;

      var token = await GetIt.instance
          .get<FlutterSecureStorage>()
          .read(key: AppConst.keyToken);
      if (token != '' && token != null) {
        options.headers['Authorization'] = 'Bearer' + token;
      }
      log('REQUEST[${options.method}] => PATH: ${options.path}');
      return super.onRequest(options, handler);
    } else {
      showDialogNoInternet();
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
