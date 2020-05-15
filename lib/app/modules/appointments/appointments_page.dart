import 'package:app_schedule_now/app/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'appointments_controller.dart';

class AppointmentsPage extends StatefulWidget {
  final String title;
  const AppointmentsPage({Key key, this.title = "Appointments"})
      : super(key: key);

  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState
    extends ModularState<AppointmentsPage, AppointmentsController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.recover();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Future<void> showSnackBar(String content) {
    final snackBarContent = SnackBar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: Color.fromARGB(255, 203, 236, 241),
          appBar: GradientAppBar(
            bottom: TabBar(tabs: [
              Tab(
                child: Text('Horários marcados'),
              ),
              Tab(
                child: Text('Horários finalizados'),
              ),
            ]),
            gradient:
                LinearGradient(colors: [Color(0xffbc4e9c), Color(0xfff80759)]),
            title: Text("Meus horários"),
            centerTitle: true,
          ),
          body: TabBarView(children: [
            Column(
              children: <Widget>[
                FutureBuilder(
                  future: controller.recover(),
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
                          return Container(
                              padding: EdgeInsets.all(0),
                              margin: EdgeInsets.all(10),
                              //color: Colors.white70,
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                  child: Text(
                                "Olá, ${snapshot.data}!",
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'RobotSlab'),
                              )));
                        }
                        break;
                    }
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Observer(
                        builder: (_) {
                          var listOfSchedules =
                              controller.listSchedulesClient.value;

                          if (controller.listSchedulesClient.value == null) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (controller.listSchedulesClient.value.isEmpty) {
                            return Center(
                                child: Text(
                              "Você nao possui horários agendados!",
                              style: TextStyle(fontSize: 20),
                            ));
                          }
                          return Card(
                            margin: EdgeInsets.all(10),
                            color: Color(0xffE1BEE7),
                            child: ListView.builder(
                                itemCount: listOfSchedules.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          color: Colors.grey[200],
                                          child: ListTile(
                                            trailing: IconButton(
                                              onPressed: () {
                                                _alert(listOfSchedules[index]
                                                    .id
                                                    .toString());
                                              },
                                              icon: Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              ),
                                            ),
                                            leading: Container(
                                              child: Image.asset(
                                                  'lib/app/assets/calendar.png'),
                                            ),
                                            title: Text(
                                                'Dia : ${listOfSchedules[index].date} \nHorario : ${listOfSchedules[index].time}'),
                                            subtitle: Text(
                                                'Nome do profissional : ${listOfSchedules[index].professionalName} \nServiço : ${listOfSchedules[index].serviceName}'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // INICIO DA SEGUNDA TAB VIEW *-------------------------*

            Column(
              children: <Widget>[
                FutureBuilder(
                  future: controller.recover(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Components.loading();
                        break;
                      case ConnectionState.none:
                        return Components.error("Olá!");
                        break;
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Components.error(snapshot.error.toString());
                        }
                        if (!snapshot.hasData) {
                          return Components.error("Olá!");
                        } else {
                          return Container(
                              padding: EdgeInsets.all(0),
                              margin: EdgeInsets.all(10),
                              //color: Colors.white70,
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                  child: Text(
                                "Olá, ${snapshot.data}!",
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'RobotSlab'),
                              )));
                        }
                        break;
                    }
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Observer(
                        builder: (_) {
                          var listOfSchedulesDone =
                              controller.listSchedulesClientDone.value;

                          if (controller.listSchedulesClientDone.value ==
                              null) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (controller
                              .listSchedulesClientDone.value.isEmpty) {
                            return Center(
                                child: Text(
                              "Você nao possui horários que já foram finalizados!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ));
                          }
                          return Card(
                            margin: EdgeInsets.all(10),
                            color: Color(0xffE1BEE7),
                            child: ListView.builder(
                                itemCount: listOfSchedulesDone.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          color: Colors.grey[200],
                                          child: ListTile(
                                            //trailing: IconButton(icon: Icon(Icons.star), onPressed: null),
                                            leading: Container(
                                              child: Image.asset(
                                                  'lib/app/assets/calendar.png'),
                                            ),
                                            title: Text(
                                                'Dia : ${listOfSchedulesDone[index].date} \nHorario : ${listOfSchedulesDone[index].time}'),
                                            subtitle: Text(
                                                'Nome do profissional : ${listOfSchedulesDone[index].professionalName} \nServiço : ${listOfSchedulesDone[index].serviceName}'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ])),
    );
  }

  Future _alert(String id) {
    String stts;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("CANCELAR HORÁRIO"),
            content: Container(
              child: Text("Você tem certeza que deseja cancelar este horário?"),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Não")),
              FlatButton(
                  onPressed: () {
                    controller.cancel(id).then((_) {
                      stts = _.toString();
                      if (stts == '200') {
                        Modular.to.pop();
                        showSnackBar("Horário cancelado com sucesso!");
                        Future.delayed(Duration(seconds: 1)).then((_) {
                          Modular.to.pushNamedAndRemoveUntil(
                              '/card', ModalRoute.withName('/'));
                        });
                      }
                    });
                  },
                  child: Text("Sim"))
            ],
          );
        });
  }
}
