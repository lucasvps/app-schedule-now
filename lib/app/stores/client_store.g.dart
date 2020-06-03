// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClientStore on _ClientStoreBase, Store {
  Computed<bool> _$isValidRegisterComputed;

  @override
  bool get isValidRegister => (_$isValidRegisterComputed ??=
          Computed<bool>(() => super.isValidRegister))
      .value;
  Computed<bool> _$isValidLoginComputed;

  @override
  bool get isValidLogin =>
      (_$isValidLoginComputed ??= Computed<bool>(() => super.isValidLogin))
          .value;

  final _$nameAtom = Atom(name: '_ClientStoreBase.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$emailAtom = Atom(name: '_ClientStoreBase.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_ClientStoreBase.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$phoneAtom = Atom(name: '_ClientStoreBase.phone');

  @override
  String get phone {
    _$phoneAtom.context.enforceReadPolicy(_$phoneAtom);
    _$phoneAtom.reportObserved();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.context.conditionallyRunInAction(() {
      super.phone = value;
      _$phoneAtom.reportChanged();
    }, _$phoneAtom, name: '${_$phoneAtom.name}_set');
  }

  final _$_ClientStoreBaseActionController =
      ActionController(name: '_ClientStoreBase');

  @override
  dynamic setName(String value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction();
    try {
      return super.setName(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMail(String value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction();
    try {
      return super.setMail(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPassword(String value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction();
    try {
      return super.setPassword(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPhone(String value) {
    final _$actionInfo = _$_ClientStoreBaseActionController.startAction();
    try {
      return super.setPhone(value);
    } finally {
      _$_ClientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'name: ${name.toString()},email: ${email.toString()},password: ${password.toString()},phone: ${phone.toString()},isValidRegister: ${isValidRegister.toString()},isValidLogin: ${isValidLogin.toString()}';
    return '{$string}';
  }
}
