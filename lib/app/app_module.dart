import 'package:app_schedule_now/app/modules/appointments/appointments_module.dart';
import 'package:app_schedule_now/app/modules/schedule/schedule_controller.dart';
import 'package:app_schedule_now/app/modules/schedule/schedule_module.dart';
import 'package:app_schedule_now/app/repositories/professional_repository.dart';
import 'package:app_schedule_now/app/modules/card/card_module.dart';
import 'package:app_schedule_now/app/modules/home/home_controller.dart';
import 'package:app_schedule_now/app/app_controller.dart';
import 'package:app_schedule_now/app/modules/register/register_module.dart';
import 'package:app_schedule_now/app/modules/services/services_module.dart';
import 'package:app_schedule_now/app/repositories/client_repository.dart';
import 'package:app_schedule_now/app/repositories/service_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:app_schedule_now/app/app_widget.dart';
import 'package:app_schedule_now/app/modules/home/home_module.dart';

import 'modules/appointments/appointments_controller.dart';
import 'modules/card/card_controller.dart';
import 'modules/register/register_controller.dart';
import 'modules/services/services_controller.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ProfessionalRepository()),
        Bind((i) => AppController()),
        Bind((i) => HomeController(i.get<ClientRepository>())),
        Bind((i) => RegisterController(i.get<ClientRepository>())),
        Bind((i) => CardController(i.get<ClientRepository>())),
        Bind((i) => ServicesController(i.get<ServiceRepository>())),
        Bind((i) => ScheduleController(i.get<ProfessionalRepository>())),
        Bind((i) => AppointmentsController(i.get<ClientRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router('/', module: HomeModule()),
        Router('/register', module: RegisterModule()),
        Router('/card', module: CardModule()),
        Router('/service', module: ServicesModule()),
        Router('/schedule', module: ScheduleModule()),
        Router('/appointments', module: AppointmentsModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
