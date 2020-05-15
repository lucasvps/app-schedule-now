import 'package:app_schedule_now/app/models/service_model.dart';
import 'package:app_schedule_now/app/repositories/service_repository.dart';
import 'package:mobx/mobx.dart';

part 'services_controller.g.dart';

class ServicesController = _ServicesControllerBase with _$ServicesController;

abstract class _ServicesControllerBase with Store {
  final ServiceRepository serviceRepository;
  var service = ServiceModel();

  @observable
  ObservableFuture<List<ServiceModel>> services;

  _ServicesControllerBase(this.serviceRepository){
    services = serviceRepository.fetchServices().asObservable();
  }

  Future<List<ServiceModel>> fetchServices() async {
    return await serviceRepository.fetchServices();
  }

}
