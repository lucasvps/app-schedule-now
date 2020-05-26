import 'dart:convert';

import 'package:app_schedule_now/app/models/client_model.dart';
import 'package:app_schedule_now/app/models/list_schedules_client_model.dart';
import 'package:app_schedule_now/app/models/recover_client_model.dart';
import 'package:app_schedule_now/app/shared/constants.dart';
import 'package:app_schedule_now/app/shared/custom_dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientRepository extends Disposable {
  var client = ClienteModel();
  var recoverClient = RecoverClientModel();

  Map<String, String> header = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    //'Authorization' : 'Bearer $preferences.'
  };

  // REGISTER
  Future registerUser(ClienteModel data) async {
    String registerUrl = ApiConstants.MAIN_URL + ApiConstants.REGISTER_CLIENT;

    var dio = CustomDio().instance;

    return await dio
        .post(registerUrl, data: data.toJson())
        .then((response) async {
      var preferences = await SharedPreferences.getInstance();
      preferences.setString("token", response.data['token']);
      Future.delayed(Duration(seconds: 2)).then((_) {
        Modular.to.pushReplacementNamed('/card');
      });

      return response.statusCode;
    }).catchError((e) {
      return null;
    });
  }

  // LOGIN
  Future loginUser(ClienteModel data) async {
    String loginUser = ApiConstants.MAIN_URL + ApiConstants.LOGIN_URL;

    var dio = CustomDio().instance;

    return await dio
        .post(loginUser, data: data.toJsonLogin())
        .then((value) async {
      var preferences = await SharedPreferences.getInstance();
      preferences.setString("token", value.data['token']);
      Future.delayed(Duration(seconds: 2)).then((_) {
        Modular.to.pushNamedAndRemoveUntil('/card', ModalRoute.withName('/card'));
      });

      return value.statusCode;
    }).catchError((err) {
      return null;
    });
  }

  // LOGOUT
  Future logoutUser() async {
    String logoutUser = ApiConstants.MAIN_URL + ApiConstants.LOGOUT_URL;

    var dio = CustomDio.withAuthentication().instance;

    return await dio.get(logoutUser).then((response) async {
      var prefs = await SharedPreferences.getInstance();
      Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
      prefs.clear();
      prefs.commit();
    });
  }

  Future resetToken() async {
    String url = ApiConstants.MAIN_URL + ApiConstants.RESET_TOKEN;

    var dio = CustomDio.withAuthentication().instance;

    return await dio.post(url).then((response) async {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString("token", response.data['token']);
    });
  } 


  // **********************************************************************************************************************

  // Cancelar um horário marcado do cliente.
  Future cancelSchedule(String id) async {
    String url = ApiConstants.MAIN_URL + ApiConstants.CANCEL_SCHEDULE + '/$id';

    String url2 =
        ApiConstants.MAIN_URL + ApiConstants.CANCEL_SCHEDULE_PROF + '/$id';

    var response = await http.delete(url, headers: header);

    var response2 = await http.delete(url2, headers: header);

    return response.statusCode;
  }


  // Recuperar dados usuario logado
  Future recoverUser() async {
    String recoverData = ApiConstants.MAIN_URL + ApiConstants.RECOVER_URL;

    var preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    //print(token);

    Map<String, String> header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(recoverData, headers: header);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      for (var item in body['data']) {
        RecoverClientModel recovered = RecoverClientModel.fromJson(item);

        preferences.setString('currentUserName', recovered.name);
        preferences.setString('currentUserEmail', recovered.email);

        recoverClient.recoveredName(recovered.name);
        recoverClient.recoveredMail(recovered.email);
        recoverClient.recoveredPhone(recovered.phone);
      }
    } else {
      //Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
    }

    return recoverClient.name;
  }

  Future<List<ListSchedulesModel>> listOfSchedules() async {
    var preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    String email = preferences.getString('currentUserEmail');

    String url = ApiConstants.MAIN_URL +
        ApiConstants.ALL_CLIENTS +
        '?conditions=email=$email';

    Map<String, String> header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(url, headers: header);

    List<ListSchedulesModel> schedules = [];

    if (response.body.isNotEmpty && response.body != null && email != null) {
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body)[0];

        for (var item in body['schedule']) {
          ListSchedulesModel schedule = ListSchedulesModel.fromJson(item);

          // Caso o horario ja tenha passado, nao aparece na lista!
          DateTime schedDate =
              new DateFormat("dd/MM/yyyy").parse(schedule.date);
          var today = DateTime.now();

          var diff = schedDate.difference(today).inDays;

          if (diff >= 0) {
            schedules.add(schedule);
          }
        }
      } else {
        Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
        preferences.clear();
        preferences.commit();
      }
    } else {
      Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
      preferences.clear();
      preferences.commit();
    }

    return schedules;
  }

  Future<List<ListSchedulesModel>> listOfSchedulesDone() async {
    var preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    String email = preferences.getString('currentUserEmail');

    String url = ApiConstants.MAIN_URL +
        ApiConstants.ALL_CLIENTS +
        '?conditions=email=$email';

    Map<String, String> header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(url, headers: header);

    List<ListSchedulesModel> schedulesDone = [];

    if (response.body.isNotEmpty && response.body != null && email != null) {
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body)[0];

        for (var item in body['schedule']) {
          ListSchedulesModel schedule = ListSchedulesModel.fromJson(item);

          // Caso o horario ja tenha passado, nao aparece na lista!
          DateTime schedDate =
              new DateFormat("dd/MM/yyyy").parse(schedule.date);
          var today = DateTime.now();
          var diff = schedDate.difference(today).inDays;

          if (diff < 0) {
            schedulesDone.add(schedule);
          }
        }
      } else {
        Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
        preferences.clear();
        preferences.commit();
      }
    } else {
      Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
      preferences.clear();
      preferences.commit();
    }

    return schedulesDone;
  }

  

  //dispose will be called automatically
  @override
  void dispose() {}
}
