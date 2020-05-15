import 'dart:convert';

import 'package:app_schedule_now/app/models/client_model.dart';
import 'package:app_schedule_now/app/models/list_schedules_client_model.dart';
import 'package:app_schedule_now/app/models/recover_client_model.dart';
import 'package:app_schedule_now/app/shared/constants.dart';
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

    var preferences = await SharedPreferences.getInstance();

    var register = null;

    return await http
        .post(registerUrl, headers: header, body: json.encode(data.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        register = json.decode(data.body);
        if (register != null) {
          preferences.setString("token", register['token']);
          Future.delayed(Duration(seconds: 2)).then((_) {
            Modular.to.pushReplacementNamed('/card');
          });
        }
      }

      return data.statusCode;
    });
  }

  // LOGIN
  Future loginUser(ClienteModel data) async {
    String loginUser = ApiConstants.MAIN_URL + ApiConstants.LOGIN_URL;

    var preferences = await SharedPreferences.getInstance();

    var response = null;

    return await http
        .post(loginUser, headers: header, body: json.encode(data.toJsonLogin()))
        .then((data) {
      if (data.statusCode == 200) {
        response = json.decode(data.body);
        if (response != null) {
          preferences.setString("token", response['token']);
          Future.delayed(Duration(seconds: 2)).then((_) {
            Modular.to.pushReplacementNamed('/card');
          });
        }
      }

      return data.statusCode;
    });
  }

  // LOGOUT
  Future logoutUser() async {
    String logoutUser = ApiConstants.MAIN_URL + ApiConstants.LOGOUT_URL;

    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    Map<String, String> headerLogout = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    return await http.get(logoutUser, headers: headerLogout).then((data) {
      if (data.statusCode == 200) {
        Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
        prefs.clear();
        prefs.commit();
      } else {
        Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
        prefs.clear();
        prefs.commit();
      }
    });
  }

  Future resetToken() async {
    String url = ApiConstants.MAIN_URL + ApiConstants.RESET_TOKEN;

    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    Map<String, String> headerReset = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    return await http.post(url, headers: headerReset).then((data) {
      if (data.statusCode == 200) {
        var response = json.decode(data.body);
        if (response != null) {
          prefs.setString("token", response['token']);
        }
      } else {
        Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
        prefs.clear();
        prefs.commit();
      }
    });
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

  Future cancelSchedule(String id) async {
    String url = ApiConstants.MAIN_URL + ApiConstants.CANCEL_SCHEDULE + '/$id';

    String url2 =
        ApiConstants.MAIN_URL + ApiConstants.CANCEL_SCHEDULE_PROF + '/$id';

    var response = await http.delete(url, headers: header);

    var response2 = await http.delete(url2, headers: header);

    return response.statusCode;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
