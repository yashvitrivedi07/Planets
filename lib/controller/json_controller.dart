import 'package:get/get.dart';
import 'package:planet_app/helper/json_helper.dart';
import 'package:planet_app/modal/planet_modal.dart';

class JsonController extends GetxController {
  List<PlanetModal> jsonData = [];

  Future<void> getData() async {
    JsonHelper jh = JsonHelper();
    jsonData = await jh.jsonParsing();
    update();
  }
}
