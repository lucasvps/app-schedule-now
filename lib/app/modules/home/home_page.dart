import 'package:app_schedule_now/app/components/widgets.dart';
import 'package:app_schedule_now/app/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Realizar Login"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    controller.recoveredUser();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') != null) {
      controller.refreshToken();
      Modular.to.pushReplacementNamed('/card');
    }
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
    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Color.fromARGB(255, 203, 236, 241),
        appBar: GradientAppBar(
          title: Text(widget.title),
          gradient:
              LinearGradient(colors: [Color(0xffbc4e9c), Color(0xfff80759)]),
          actions: <Widget>[
            RaisedButton(
              child: Text('Novo cadastro'),
              color: Colors.transparent,
              onPressed: () {
                Modular.to.pushReplacementNamed('/register');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 0.39,
                  height: MediaQuery.of(context).size.width * 0.39,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://image.freepik.com/free-vector/businessman-profile-cartoon_18591-58479.jpg")))),
              _sized(),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white54),
                  child: Column(
                    children: <Widget>[
                      Observer(
                        builder: (_) {
                          return Components.textField(
                              label: "Email",
                              icon: Icons.email,
                              onChanged: controller.client.setMail,
                              errorText: controller.validateMailController);
                        },
                      ),
                      _sized(),
                      Observer(
                        builder: (_) {
                          return textField(
                              label: "Senha",
                              icon: Icons.lock,
                              onChanged: controller.client.setPassword,
                              errorText: controller.validatePassController);
                        },
                      ),
                      _sized(),
                      Observer(builder: (_) {
                        return _button(
                          text: "Realizar login",
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  //

  Widget _button({String text}) {
    String stts;
    return RaisedButton(
        child: Text(text),
        color: Colors.blue[400],
        onPressed: controller.client.isValidLogin
            ? () {
                var data = ClienteModel(
                    email: controller.client.email,
                    password: controller.client.password);

                controller.loginUser(data).then((response) {
                  
                  controller.recoveredUser();
                  stts = response.toString();
                  print('home page $stts');
                  if (stts != '200') {
                    _alert();
                  } else {
                    showSnackBar('Login realizado com sucesso!');
                  }
                });
              }
            : null);
  }

  Widget _sized() {
    return SizedBox(
      height: 20,
    );
  }

  Future _alert() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("Não foi possivel realizar login!"),
            content: Container(
              child: Text("Email ou senha incorretos!"),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  Widget textField(
      {onChanged,
      String Function() errorText,
      String label,
      IconData icon,
      type}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 5),
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(30)),
        child: Observer(builder: (_) {
          return TextField(
            keyboardType: type,
            onChanged: onChanged,
            obscureText: controller.isObscure,
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: controller.isObscure
                    ? IconButton(
                        icon: Icon(Icons.visibility_off),
                        onPressed: controller.changeVisibility)
                    : IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: controller.changeVisibility),
                prefixIcon: Icon(icon),
                errorText: errorText(),
                errorStyle: TextStyle(),
                hintText: icon == Icons.phone ? "(00) 00000-0000" : "",
                labelText: "$label",
                labelStyle: TextStyle(color: Colors.black)),
          );
        }),
      ),
    );
  }
}
