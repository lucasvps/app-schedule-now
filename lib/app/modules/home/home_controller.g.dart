// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$isObscureAtom = Atom(name: '_HomeControllerBase.isObscure');

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

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void changeVisibility() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.changeVisibility();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'isObscure: ${isObscure.toString()}';
    return '{$string}';
  }
}
