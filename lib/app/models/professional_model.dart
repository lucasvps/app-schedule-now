import 'package:mobx/mobx.dart';

part 'professional_model.g.dart';

class ProfessionalModel = _ProfessionalModelBase with _$ProfessionalModel;

abstract class _ProfessionalModelBase with Store {
    
  @observable
  int id;
  @action
  setProfId(int value) => id = value;

  @observable
  String professionalName;
  @action
  setProfName(String value) => professionalName = value;

  @observable
  String professionalPhone;

  @computed
  bool get buttonValid{
    return validateProfName() == null;
  }

  String validateProfName() {
    if (professionalName == null || professionalName.isEmpty) {
      return "";
    }

    return null;
  }

  _ProfessionalModelBase({this.id, this.professionalName, this.professionalPhone});

  _ProfessionalModelBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    professionalName = json['professionalName'];
    professionalPhone = json['professionalPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['professionalName'] = this.professionalName;
    data['professionalPhone'] = this.professionalPhone;
    return data;
  }

  


}