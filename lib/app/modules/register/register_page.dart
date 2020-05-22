import 'package:app_schedule_now/app/components/shared_widgets.dart';
import 'package:app_schedule_now/app/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({Key key, this.title = "Cadastro de Cliente"})
      : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState
    extends ModularState<RegisterPage, RegisterController> {
  //use 'controller' variable to access controller

  var model = ClienteModel();

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Color.fromARGB(255, 203, 236, 241),
        appBar: GradientAppBar(
          actions: <Widget>[
            RaisedButton(
              child: Text('Realizar login'),
              color: Colors.transparent,
              onPressed: () {
                Modular.to.pushReplacementNamed('/');
              },
            )
          ],
          title: Text(widget.title),
          gradient:
              LinearGradient(colors: [Color(0xffbc4e9c), Color(0xfff80759)]),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            padding: EdgeInsets.fromLTRB(7, 0, 7, 12),
            child: SingleChildScrollView(
              child: Container(
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
                            label: "Nome",
                            onChanged: controller.client.setName,
                            errorText: controller.validateNameController,
                            icon: Icons.person,
                            type: TextInputType.text);
                      },
                    ),
                    _sized(20),
                    Observer(
                      builder: (BuildContext context) {
                        return Components.textField(
                            label: "Email",
                            onChanged: controller.client.setMail,
                            errorText: controller.validateMailController,
                            icon: Icons.mail,
                            type: TextInputType.emailAddress);
                      },
                    ),
                    _sized(20),
                    Observer(
                      builder: (BuildContext context) {
                        return textField(
                            label: "Senha",
                            onChanged: controller.client.setPassword,
                            errorText: controller.validatePassController,
                            icon: Icons.lock,
                            type: TextInputType.text);
                      },
                    ),
                    _sized(20),
                    Observer(
                      builder: (_) {
                        return Components.textField(
                          errorText: controller.validatePhoneController,
                          icon: Icons.phone,
                          label: "Telefone",
                          onChanged: controller.client.setPhone,
                          type: TextInputType.phone,
                        );
                      },
                    ),
                    _sized(40),
                    Observer(builder: (_) {
                      return _button(context: context);
                    })
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _button({BuildContext context}) {
    String statusCode;
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: RaisedButton(
        onPressed: controller.client.isValidRegister
            ? () {
                var data = ClienteModel(
                    name: controller.client.name,
                    email: controller.client.email,
                    password: controller.client.password,
                    phone: controller.client.phone);

                controller.registerClient(data).then((response) {
                  statusCode = response.toString();
                  if (statusCode != '200') {
                    Components.alert(
                        context,
                        'Não foi possivel realizar o cadastro!',
                        'Este email já está em uso!',
                        'register');
                  } else {
                    Components.showSnackBar(
                        "Cadastro realizado com sucesso!", _scaffoldkey);
                    controller.recoveredUser();
                  }
                });
              }
            : null,
        child: Text("Registrar"),
        color: Colors.blue[400],
      ),
    );
  }

  Widget _sized(double num) {
    return SizedBox(
      height: num,
    );
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
          return TextFormField(
            initialValue: "",
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
                hintText: icon == Icons.phone ? "(00) 00000-0000" : "",
                labelText: "$label",
                labelStyle: TextStyle(color: Colors.black)),
          );
        }),
      ),
    );
  }
}
