// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ScheduledModel on _ScheduledModelBase, Store {
  Computed<bool> _$isDateValidComputed;

  @override
  bool get isDateValid =>
      (_$isDateValidComputed ??= Computed<bool>(() => super.isDateValid)).value;
  Computed<bool> _$isTimeValidComputed;

  @override
  bool get isTimeValid =>
      (_$isTimeValidComputed ??= Computed<bool>(() => super.isTimeValid)).value;

  final _$timeAtom = Atom(name: '_ScheduledModelBase.time');

  @override
  String get time {
    _$timeAtom.context.enforceReadPolicy(_$timeAtom);
    _$timeAtom.reportObserved();
    return super.time;
  }

  @override
  set time(String value) {
    _$timeAtom.context.conditionallyRunInAction(() {
      super.time = value;
      _$timeAtom.reportChanged();
    }, _$timeAtom, name: '${_$timeAtom.name}_set');
  }

  final _$brDateAtom = Atom(name: '_ScheduledModelBase.brDate');

  @override
  String get brDate {
    _$brDateAtom.context.enforceReadPolicy(_$brDateAtom);
    _$brDateAtom.reportObserved();
    return super.brDate;
  }

  @override
  set brDate(String value) {
    _$brDateAtom.context.conditionallyRunInAction(() {
      super.brDate = value;
      _$brDateAtom.reportChanged();
    }, _$brDateAtom, name: '${_$brDateAtom.name}_set');
  }

  final _$usDateAtom = Atom(name: '_ScheduledModelBase.usDate');

  @override
  String get usDate {
    _$usDateAtom.context.enforceReadPolicy(_$usDateAtom);
    _$usDateAtom.reportObserved();
    return super.usDate;
  }

  @override
  set usDate(String value) {
    _$usDateAtom.context.conditionallyRunInAction(() {
      super.usDate = value;
      _$usDateAtom.reportChanged();
    }, _$usDateAtom, name: '${_$usDateAtom.name}_set');
  }

  final _$_ScheduledModelBaseActionController =
      ActionController(name: '_ScheduledModelBase');

  @override
  dynamic setTime(String value) {
    final _$actionInfo = _$_ScheduledModelBaseActionController.startAction();
    try {
      return super.setTime(value);
    } finally {
      _$_ScheduledModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBRDate(String value) {
    final _$actionInfo = _$_ScheduledModelBaseActionController.startAction();
    try {
      return super.setBRDate(value);
    } finally {
      _$_ScheduledModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUSDate(String value) {
    final _$actionInfo = _$_ScheduledModelBaseActionController.startAction();
    try {
      return super.setUSDate(value);
    } finally {
      _$_ScheduledModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'time: ${time.toString()},brDate: ${brDate.toString()},usDate: ${usDate.toString()},isDateValid: ${isDateValid.toString()},isTimeValid: ${isTimeValid.toString()}';
    return '{$string}';
  }
}
