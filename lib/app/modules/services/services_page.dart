import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'services_controller.dart';

class ServicesPage extends StatefulWidget {
  final String title;
  const ServicesPage({Key key, this.title = "Serviços Disponiveis"})
      : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState
    extends ModularState<ServicesPage, ServicesController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 203, 236, 241),
      appBar: GradientAppBar(
        title: Text(widget.title),
        centerTitle: true,
        gradient:
            LinearGradient(colors: [Color(0xffbc4e9c), Color(0xfff80759)]),
      ),
      body: _card(),
    );
  }

  Widget _card() {
    return Observer(
      builder: (BuildContext context) {
        var services = controller.services.value;

        if (controller.services.value == null)
          return Center(child: CircularProgressIndicator());

        return ListView.builder(
          itemCount: services.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xff800080),
                Color(0xffffc0cb),
                // Color(0xffee9ca7),
                // Color(0xff),
              ])),
              padding: EdgeInsets.fromLTRB(0, 10, 2, 10),
              margin: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Center(
                      child: Text(
                        services[index].serviceName,
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Amatic'
                        ),
                      ),
                    ),
                    subtitle: Center(
                      child: Text(
                        services[index].serviceDescription,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Patrick'
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Color(0xffffc0cb),
                    onPressed: () {
                      print('ID = ${services[index].id}');
                      Modular.to.pushNamed(
                          '/schedule/${services[index].nameOfProfession}');
                    },
                    child: Text("Marcar Horário"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
