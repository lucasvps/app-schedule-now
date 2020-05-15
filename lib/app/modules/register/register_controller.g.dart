// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterController on _RegisterControllerBase, Store {
  final _$clientsAtom = Atom(name: '_RegisterControllerBase.clients');

  @override
  ObservableFuture<List<ClienteModel>> get clients {
    _$clientsAtom.context.enforceReadPolicy(_$clientsAtom);
    _$clientsAtom.reportObserved();
    return super.clients;
  }

  @override
  set clients(ObservableFuture<List<ClienteModel>> value) {
    _$clientsAtom.context.conditionallyRunInAction(() {
      super.clients = value;
      _$clientsAtom.reportChanged();
    }, _$clientsAtom, name: '${_$clientsAtom.name}_set');
  }

  final _$isObscureAtom = Atom(name: '_RegisterControllerBase.isObscure');

  @override
  bool get isObscure {
    _$isObscureAtom.context.enforceReadPolicy(_$isObscureAtom);
    _$isObscureAtom.reportObserved();
    return super.isObscure;
  }

  @override
  set isObscure(bool value) {
    _$isObscureAtom.context.conditionallyRunInAction(() {
      super.isObscure = value;
      _$isObscureAtom.reportChanged();
    }, _$isObscureAtom, name: '${_$isObscureAtom.name}_set');
  }

  final _$_RegisterControllerBaseActionController =
      ActionController(name: '_RegisterControllerBase');

  @override
  void changeVisibility() {
    final _$actionInfo =
        _$_RegisterControllerBaseActionController.startAction();
    try {
      return super.changeVisibility();
    } finally {
      _$_RegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'clients: ${clients.toString()},isObscure: ${isObscure.toString()}';
    return '{$string}';
  }
}
