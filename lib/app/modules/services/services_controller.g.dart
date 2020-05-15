// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServicesController on _ServicesControllerBase, Store {
  final _$servicesAtom = Atom(name: '_ServicesControllerBase.services');

  @override
  ObservableFuture<List<ServiceModel>> get services {
    _$servicesAtom.context.enforceReadPolicy(_$servicesAtom);
    _$servicesAtom.reportObserved();
    return super.services;
  }

  @override
  set services(ObservableFuture<List<ServiceModel>> value) {
    _$servicesAtom.context.conditionallyRunInAction(() {
      super.services = value;
      _$servicesAtom.reportChanged();
    }, _$servicesAtom, name: '${_$servicesAtom.name}_set');
  }

  @override
  String toString() {
    final string = 'services: ${services.toString()}';
    return '{$string}';
  }
}
