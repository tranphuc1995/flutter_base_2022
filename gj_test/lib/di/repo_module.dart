import 'package:get_it/get_it.dart';
import 'package:gj_test/repository/test_repository.dart';
import 'package:gj_test/repository/test_repository_impl.dart';

void provideTestRepository() {
  GetIt.instance.registerSingleton<TestRepository>(TestRepositoryImpl());
}
