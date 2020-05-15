// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppointmentsController on _AppointmentsControllerBase, Store {
  final _$listSchedulesClientAtom =
      Atom(name: '_AppointmentsControllerBase.listSchedulesClient');

  @override
  ObservableFuture<List<ListSchedulesModel>> get listSchedulesClient {
    _$listSchedulesClientAtom.context
        .enforceReadPolicy(_$listSchedulesClientAtom);
    _$listSchedulesClientAtom.reportObserved();
    return super.listSchedulesClient;
  }

  @override
  set listSchedulesClient(ObservableFuture<List<ListSchedulesModel>> value) {
    _$listSchedulesClientAtom.context.conditionallyRunInAction(() {
      super.listSchedulesClient = value;
      _$listSchedulesClientAtom.reportChanged();
    }, _$listSchedulesClientAtom,
        name: '${_$listSchedulesClientAtom.name}_set');
  }

  final _$listSchedulesClientDoneAtom =
      Atom(name: '_AppointmentsControllerBase.listSchedulesClientDone');

  @override
  ObservableFuture<List<ListSchedulesModel>> get listSchedulesClientDone {
    _$listSchedulesClientDoneAtom.context
        .enforceReadPolicy(_$listSchedulesClientDoneAtom);
    _$listSchedulesClientDoneAtom.reportObserved();
    return super.listSchedulesClientDone;
  }

  @override
  set listSchedulesClientDone(
      ObservableFuture<List<ListSchedulesModel>> value) {
    _$listSchedulesClientDoneAtom.context.conditionallyRunInAction(() {
      super.listSchedulesClientDone = value;
      _$listSchedulesClientDoneAtom.reportChanged();
    }, _$listSchedulesClientDoneAtom,
        name: '${_$listSchedulesClientDoneAtom.name}_set');
  }

  @override
  String toString() {
    final string =
        'listSchedulesClient: ${listSchedulesClient.toString()},listSchedulesClientDone: ${listSchedulesClientDone.toString()}';
    return '{$string}';
  }
}
