import 'package:app_schedule_now/app/components/shared_widgets.dart';
import 'package:app_schedule_now/app/models/professional_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'schedule_controller.dart';

class SchedulePage extends StatefulWidget {
  final String title;
  final String nameOfProfession;

  const SchedulePage({Key key, this.title = "Schedule", this.nameOfProfession})
      : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState
    extends ModularState<SchedulePage, ScheduleController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 203, 236, 241),
        appBar: GradientAppBar(
          title: Text('Schedule Now'),
          centerTitle: true,
          gradient:
              LinearGradient(colors: [Color(0xffbc4e9c), Color(0xfff80759)]),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder(
                  future: controller.profByService(widget.nameOfProfession),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Components.loading();
                        break;
                      case ConnectionState.none:
                        return Components.error("No connection has been made");
                        break;
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Components.error(snapshot.error.toString());
                        }
                        if (!snapshot.hasData) {
                          return Components.error("No data");
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                dropDownMenu(snapshot.data),
                              ],
                            ),
                          );
                        }
                        break;
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget dropDownMenu(List<ProfessionalModel> prof) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Color(0xffEDE7F6),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                        child: Text(
                      "Serviço escolhido : ${widget.nameOfProfession}",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontFamily: 'Indie'),
                    )),
                  ),
                ),
                Components.divider(),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                      items: prof.map((item) {
                        return DropdownMenuItem(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Text(
                              item.professionalName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          value: item.professionalName.toString(),
                        );
                      }).toList(),
                      hint: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Center(
                          child: Text("Escolha o profissional",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontFamily: 'Indie')),
                        ),
                      ),
                      onChanged: (_) async {
                        controller.professional.setProfName(_);
                        String idString = await controller.getId(_);
                        int id = int.parse(idString);
                        controller.professional.setProfId(id);
                        controller.makeScheduleClient.setScheduleProfName(_);
                      },
                      icon: Icon(
                        Icons.arrow_downward,
                        size: 30,
                        color: Color(0xfff80759),
                      ),
                      style: TextStyle(fontSize: 30, color: Colors.black),
                      value: controller.professional.professionalName),
                ),
                Components.divider(),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Observer(builder: (_) {
                  return controller.schedule.brDate == null
                      ? Text("")
                      : Center(
                          child: Text(
                            'Data escolhida : ${controller.schedule.brDate}',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                }),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Observer(builder: (_) {
                  return Container(
                      width: MediaQuery.of(context).size.width * 0.62,
                      child: RaisedButton(
                          color: Color(0xffE1BEE7),
                          child: controller.schedule.isDateValid
                              ? Text('Escolher outra data!')
                              : Text("Escolher data!"),
                          onPressed: () {
                            _selectDate(context);
                          }));
                }),
                Components.divider(),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.07,
                ),
                Observer(builder: (_) {
                  return RaisedButton(
                    color: Color(0xff9C27B0),
                    onPressed: (controller.schedule.isDateValid &&
                            controller.professional.buttonValid)
                        ? () {
                            _alert();
                          }
                        : null,
                    child: !controller.schedule.isDateValid
                        ? Icon(Icons.arrow_right)
                        : Text("ESCOLHER HORÁRIO!"),
                  );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //locale: Locale('pt'),
        firstDate: DateTime.now().subtract(Duration(days: 1)),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (picked != null) {
      var brDate = formatDate(picked, [dd, '/', mm, '/', yyyy]);
      var usDate = formatDate(picked, [yyyy, '/', mm, '/', dd]);
      // Seta datas para mostrar ao usuario;
      controller.schedule.setBRDate(brDate);
      controller.schedule.setUSDate(usDate);

      //Seta data para marcar o horário;
      controller.makeScheduleClient.setScheduleDate(usDate);
    }
  }

  Future _alert() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("CONFIRMAR DADOS"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                      'Profissional: ${controller.professional.professionalName}\nData: ${controller.schedule.brDate}'),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancelar")),
              FlatButton(
                  onPressed: () {
                    Modular.to.pushNamedAndRemoveUntil(
                        '/schedule/time/${widget.nameOfProfession}',
                        ModalRoute.withName('/'));
                  },
                  child: Text("Confirmar"))
            ],
          );
        });
  }
}
