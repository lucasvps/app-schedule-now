import 'package:mobx/mobx.dart';

part 'scheduled_model.g.dart';

class ScheduledModel = _ScheduledModelBase with _$ScheduledModel;

abstract class _ScheduledModelBase with Store {


  // ESTE MODEL É UTILIZADO PARA :
  // - Fazer a buscar dos horarios de trabalho do estabelecimento;
  // - Fazer a busca dos horarios marcados por um profissional, em determinado dia;
  
  @observable
  String time;
  @action
  setTime(String value) => time = value;

  // Utilizado apenas para salvar a data e enviar, nao para recuperar!
  @observable
  String brDate;
  @action
  setBRDate(String value) => brDate = value;

  @observable
  String usDate;
  @action
  setUSDate(String value) => usDate = value;



  _ScheduledModelBase({this.time});

  _ScheduledModelBase.fromJson(Map<String, dynamic> json) {
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    return data;
  }

  String validateDate() {
    if (brDate == null || brDate.isEmpty) {
      return "";
    }

    return null;
  }

  String validateTime() {
    if (time == null || time.isEmpty) {
      return "";
    }

    return null;
  }
  
  @computed
  bool get isDateValid{
    return validateDate() == null;
  }

  @computed
  bool get isTimeValid{
    return validateTime() == null;
  }


}