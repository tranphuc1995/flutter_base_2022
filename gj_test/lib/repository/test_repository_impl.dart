import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gj_test/repository/test_repository.dart';

class TestRepositoryImpl extends TestRepository {
  final String apiKey = '106430786838d70ef6fe1d70175f07a5';

  @override
  Future<String> getData() async {
    try {
      var response = await GetIt.instance
          .get<Dio>()
          .get('/popular?api_key=$apiKey&page=1');
      return response.toString();
    } catch (e) {
      return '';
    }
  }
}
