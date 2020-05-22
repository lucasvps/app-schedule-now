
import 'package:app_schedule_now/app/models/service_model.dart';
import 'package:app_schedule_now/app/shared/constants.dart';
import 'package:app_schedule_now/app/shared/custom_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ServiceRepository extends Disposable {
  Future<List<ServiceModel>> fetchServices() async {
    String servicesUrl = ApiConstants.MAIN_URL + ApiConstants.ALL_SERVICES;

    var dio = CustomDio.withAuthentication().instance;

    return await dio.get(servicesUrl).then((response) {
      List<ServiceModel> services = [];
      for (var item in response.data['data']) {
        ServiceModel service = ServiceModel.fromJson(item);
        services.add(service);
      }

      return services;
    });
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
