class ListSchedulesModel {
  int id;
  String date;
  String time;
  String professionalName;
  String serviceName;

  ListSchedulesModel({this.date, this.time, this.professionalName, this.serviceName});

  ListSchedulesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    professionalName = json['professionalName'];
    serviceName = json['serviceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['professionalName'] = this.professionalName;
    data['serviceName'] = this.serviceName;
    return data;
  }
}