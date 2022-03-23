import 'package:get_it/get_it.dart';
import 'package:core/router/navigation_service.dart';
void provideRouterModule(){
  GetIt.instance.registerLazySingleton<NavigationService>(() => NavigationService());
}