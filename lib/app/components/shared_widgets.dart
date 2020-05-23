import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Components {
  static Future<void> showSnackBar(String content, key) {
    final snackBarContent = SnackBar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
    );

    key.currentState.showSnackBar(snackBarContent);
  }

  static Future alert(context, title, content, String route) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Container(
              child: Text(content),
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

  static Widget error(String e) {
    return Container(
      child: Center(
        child: Text(e),
      ),
    );
  }

  static Widget sized() {
    return SizedBox(
      height: 20,
    );
  }

  static Widget divider() {
    return Divider(
      color: Colors.black,
    );
  }

  static Widget loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static var maskTextInputFormatter = MaskTextInputFormatter(
      mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});
  static var maskInputFormatter = MaskTextInputFormatter(mask: "");

  static Widget textField(
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
        child: TextField(
          keyboardType: type,
          inputFormatters: icon == Icons.phone
              ? [maskTextInputFormatter]
              : [BlacklistingTextInputFormatter(RegExp("[/\\\\]"))],
          onChanged: onChanged,
          obscureText: icon == Icons.lock ? true : false,
          decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: icon == Icons.lock ? Icon(Icons.visibility) : null,
              prefixIcon: Icon(icon),
              errorText: errorText(),
              errorStyle: TextStyle(),
              hintText: icon == Icons.phone ? "(00) 00000-0000" : "",
              labelText: "$label",
              labelStyle: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
