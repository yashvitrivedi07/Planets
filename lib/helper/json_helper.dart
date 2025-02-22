import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:planet_app/modal/planet_modal.dart';

class JsonHelper {
  Future<List<PlanetModal>> jsonParsing() async {
    String json = await rootBundle.loadString("asset/json");
    List<dynamic> list = jsonDecode(json);
    List<PlanetModal> modal = list.map((e) => PlanetModal.toModal(e)).toList();
    return modal;
  }
}
