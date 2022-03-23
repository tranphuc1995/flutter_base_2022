import 'package:core/di/network_module.dart';
import 'package:core/di/router_module.dart';

void buildGjCoreDI() {
  provideNetworkModule();
  provideRouterModule();
}
