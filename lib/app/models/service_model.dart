
class ServiceModel {
  int id;
  String serviceName;
  String serviceDescription;
  String nameOfProfession;

  ServiceModel({
    this.id,
    this.serviceName,
    this.serviceDescription,
    this.nameOfProfession
  });



  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['serviceName'];
    serviceDescription = json['serviceDescription'];
    nameOfProfession = json['nameOfProfession'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceName'] = this.serviceName;
    data['serviceDescription'] = this.serviceDescription;
    data['nameOfProfession'] = this.nameOfProfession;
    
    return data;
  }
}
