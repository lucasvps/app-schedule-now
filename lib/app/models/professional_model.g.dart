// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfessionalModel on _ProfessionalModelBase, Store {
  Computed<bool> _$buttonValidComputed;

  @override
  bool get buttonValid =>
      (_$buttonValidComputed ??= Computed<bool>(() => super.buttonValid)).value;

  final _$idAtom = Atom(name: '_ProfessionalModelBase.id');

  @override
  int get id {
    _$idAtom.context.enforceReadPolicy(_$idAtom);
    _$idAtom.reportObserved();
    return super.id;
  }

  @override
  set id(int value) {
    _$idAtom.context.conditionallyRunInAction(() {
      super.id = value;
      _$idAtom.reportChanged();
    }, _$idAtom, name: '${_$idAtom.name}_set');
  }

  final _$professionalNameAtom =
      Atom(name: '_ProfessionalModelBase.professionalName');

  @override
  String get professionalName {
    _$professionalNameAtom.context.enforceReadPolicy(_$professionalNameAtom);
    _$professionalNameAtom.reportObserved();
    return super.professionalName;
  }

  @override
  set professionalName(String value) {
    _$professionalNameAtom.context.conditionallyRunInAction(() {
      super.professionalName = value;
      _$professionalNameAtom.reportChanged();
    }, _$professionalNameAtom, name: '${_$professionalNameAtom.name}_set');
  }

  final _$professionalPhoneAtom =
      Atom(name: '_ProfessionalModelBase.professionalPhone');

  @override
  String get professionalPhone {
    _$professionalPhoneAtom.context.enforceReadPolicy(_$professionalPhoneAtom);
    _$professionalPhoneAtom.reportObserved();
    return super.professionalPhone;
  }

  @override
  set professionalPhone(String value) {
    _$professionalPhoneAtom.context.conditionallyRunInAction(() {
      super.professionalPhone = value;
      _$professionalPhoneAtom.reportChanged();
    }, _$professionalPhoneAtom, name: '${_$professionalPhoneAtom.name}_set');
  }

  final _$_ProfessionalModelBaseActionController =
      ActionController(name: '_ProfessionalModelBase');

  @override
  dynamic setProfId(int value) {
    final _$actionInfo = _$_ProfessionalModelBaseActionController.startAction();
    try {
      return super.setProfId(value);
    } finally {
      _$_ProfessionalModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setProfName(String value) {
    final _$actionInfo = _$_ProfessionalModelBaseActionController.startAction();
    try {
      return super.setProfName(value);
    } finally {
      _$_ProfessionalModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'id: ${id.toString()},professionalName: ${professionalName.toString()},professionalPhone: ${professionalPhone.toString()},buttonValid: ${buttonValid.toString()}';
    return '{$string}';
  }
}
