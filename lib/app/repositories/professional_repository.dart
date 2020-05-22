import 'dart:convert';

import 'package:app_schedule_now/app/models/make_schedule_client_model.dart';
import 'package:app_schedule_now/app/models/make_schedule_professional_model.dart';
import 'package:app_schedule_now/app/models/professional_model.dart';
import 'package:app_schedule_now/app/models/scheduled_model.dart';
import 'package:app_schedule_now/app/shared/constants.dart';
import 'package:app_schedule_now/app/shared/custom_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfessionalRepository extends Disposable {
  var professional = ProfessionalModel();

  // Retorna o ID do profissional
  Future getIdByName(String name) async {
    name = name.toString();
    String nameIdURL =
        "https://schedule-now.herokuapp.com/api/v1/professional/id/$name";

    var dio = CustomDio.withAuthentication().instance;

    return await dio.get(nameIdURL).then((value) {
      return value.data;
    }).catchError((e) {
      return 0;
    });
  }

  // Lista de profissionais de cada serviço
  Future<List<ProfessionalModel>> professionalsByService(String service) async {
    String url =
        ApiConstants.MAIN_URL + ApiConstants.PROFESSIONAL_BY_SERVICE + service;

    var dio = CustomDio.withAuthentication().instance;

    return await dio.get(url).then((response) {
      List<ProfessionalModel> professionals = [];

      for (var item in response.data['data']) {
        ProfessionalModel prof = ProfessionalModel.fromJson(item);
        professionals.add(prof);
      }

      return professionals;
    });
  }

  // MARCAR O HORARIO PRO PROFISSIONAL!
  Future makeScheduleByProfessional(
      MakeScheduleProfessionalModel data, String id) async {
    String url = ApiConstants.MAIN_URL +
        ApiConstants.MAKE_SCHEDULE_BY_PROFESSIONAL +
        '$id';

    var dio = CustomDio.withAuthentication().instance;

    return await dio.put(url, data: data.toJson());
  }

  // MARCAR O HORARIO PRO CLIENTE!
  Future makeScheduleByClient(MakeScheduleClientModel data) async {
    String url = ApiConstants.MAIN_URL + ApiConstants.MAKE_SCHEDULE_BY_CLIENT;

    var dio = CustomDio.withAuthentication().instance;

    return await dio.put(url, data: data.toJson());

  }

  

  // *******************************************************************************************************************************

  // FUNÇÃO QUE RETORNA A LISTA DE HORARIOS DISPONIVEIS DE CADA PROFISSIONAL
  // DE ACORDO COM O DIA ESCOLHIDO!
  Future scheduledTime(String date, String profId) async {
    var preferences = await SharedPreferences.getInstance();

    String token = preferences.getString('token');

    Map<String, String> header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    //Horários do profissional no determinado dia!
    String url = ApiConstants.MAIN_URL +
        ApiConstants.SCHEDULED_URL +
        '$date' +
        ';professional_id=$profId';

    // Horários padrões de atendimento do estabelecimento!
    String urlTwo = ApiConstants.MAIN_URL + '/schedules';

    var response = await http.get(url, headers: header);
    var responseTwo = await http.get(urlTwo, headers: header);

    List<ScheduledModel> profList = [];

    // Do estabelecimento
    if (responseTwo.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(responseTwo.body);

      for (var item in body['data']) {
        ScheduledModel sched = ScheduledModel.fromJson(item);
        profList.add(sched);
      }
    }

    // De cada profissional
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      for (var item in body['data']) {
        ScheduledModel sched = ScheduledModel.fromJson(item);
        profList.removeWhere((str) => str.time == sched.time);
      }
    }

    return profList;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
