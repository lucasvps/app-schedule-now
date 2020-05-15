import 'dart:convert';

import 'package:app_schedule_now/app/models/service_model.dart';
import 'package:app_schedule_now/app/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceRepository extends Disposable {
  Future<List<ServiceModel>> fetchServices() async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    Map<String, String> header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    String servicesUrl = ApiConstants.MAIN_URL + ApiConstants.ALL_SERVICES;

    var response = await http.get(servicesUrl, headers: header);

    List<ServiceModel> services = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      for (var item in body['data']) {
        ServiceModel service = ServiceModel.fromJson(item);

        services.add(service);
      }
    } else {
      prefs.clear();
      prefs.commit();
      Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
    }

    return services;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
