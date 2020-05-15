import 'package:mobx/mobx.dart';

class MakeScheduleProfessionalModel {
  @observable
  String date;
  @action
  setScheduleDate(String value) => date = value;

  @observable
  String time;
  @action
  setScheduletime(String value) => time = value;

  MakeScheduleProfessionalModel({
    this.date,
    this.time,
  });

  MakeScheduleProfessionalModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;

    return data;
  }
}
