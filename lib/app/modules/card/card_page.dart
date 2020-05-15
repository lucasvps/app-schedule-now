import 'package:app_schedule_now/app/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'card_controller.dart';

class CardPage extends StatefulWidget {
  final String title;
  const CardPage({Key key, this.title = "Schedule Now"}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends ModularState<CardPage, CardController> {
  //use 'controller' variable to access controller

  final client = ClienteModel();
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 203, 236, 241),
      appBar: GradientAppBar(
        title: Text(widget.title),
        centerTitle: true,
        gradient: LinearGradient(colors: [
          Color(0xffbc4e9c),
          Color(0xfff80759)
        ]),
        actions: <Widget>[
          RaisedButton(
            color: Colors.transparent,
            onPressed: () {
              controller.logout();
              
            },
            child: Text("Sair", style: TextStyle(fontSize: 23),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _container("Consultar Serviços", "lib/app/assets/search.png", '/service'),
            _container("Ver meus horários", "lib/app/assets/calendar.png", '/appointments'),
          ],
        ),
      ),
      //drawer: _drawer(),
    );
  }


  

  
  Widget _container(String text, String url, String nextPage) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed(nextPage);
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.80,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                   Color(0xffee9ca7),
                    Color(0xffffc0cb),
                ],
              )),
          child: Row(
            children: <Widget>[
              _image(url: url),
              _sized(),
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, fontFamily: 'RobotSlab'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _image({String url}) {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
        width: MediaQuery.of(context).size.width * 0.16,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: new BoxDecoration(
            image: new DecorationImage(
                fit: BoxFit.contain, image: AssetImage(url))));
  }

  Widget _sized() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1,
    );
  }

  

  /*Widget _drawer() {
    return SafeArea(
      child: Drawer(
        child: Container(
            color: Colors.grey,
            child: Observer(
              builder: (BuildContext context) {
                var currentUser = controller.client.value;

                if (controller.client.value == null)
                  return Center(child: CircularProgressIndicator());

                return ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      leading: Icon(Icons.subdirectory_arrow_right),
                      title: Text(
                        client.name,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        client.email,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                );
              },
            )),
      ),
    );
  }*/
}
