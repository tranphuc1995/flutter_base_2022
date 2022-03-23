import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:core/network/app_interceptor.dart';

void provideNetworkModule() {
  GetIt.instance
      .registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());

  GetIt.instance.registerSingleton<AppInterceptor>(AppInterceptor());

  GetIt.instance.registerSingleton<Dio>(
      Dio()..interceptors.add(GetIt.instance.get<AppInterceptor>()));
}
