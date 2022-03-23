import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:gj_test/model/test_data.dart';
import 'package:gj_test/repository/test_repository.dart';

class TestScreenController extends GetxController {
  var repo = GetIt.instance.get<TestRepository>();
  Future<void> getData(ValueSetter<TestData> callBack) async {
    var data = await repo.getData();
    callBack(TestData(dataDemo: data));
  }
}
