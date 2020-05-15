import 'package:mobx/mobx.dart';

class MakeScheduleClientModel {
  
  @observable
  String date;
  @action
  setScheduleDate(String value) => date = value;

  @observable
  String time;
  @action
  setScheduletime(String value) => time = value;

  @observable
  String professionalName;
  @action
  setScheduleProfName(String value) => professionalName = value;

  @observable
  String serviceName;
  @action
  setScheduleServiceName(String value) => serviceName = value;
 
  
  MakeScheduleClientModel(
      {this.date,
      this.time,
      this.professionalName,
      this.serviceName,
      });

  MakeScheduleClientModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    professionalName = json['professionalName'];
    serviceName = json['serviceName'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    data['professionalName'] = this.professionalName;
    data['serviceName'] = this.serviceName;
    
    return data;
  }
}