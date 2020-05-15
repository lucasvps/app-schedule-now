import 'package:app_schedule_now/app/modules/schedule/time/time_controller.dart';

import 'package:app_schedule_now/app/modules/schedule/schedule_controller.dart';
import 'package:app_schedule_now/app/modules/schedule/time/time_page.dart';
import 'package:app_schedule_now/app/repositories/client_repository.dart';
import 'package:app_schedule_now/app/repositories/professional_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:app_schedule_now/app/modules/schedule/schedule_page.dart';

class ScheduleModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ClientRepository()),
        Bind((i) => TimeController(i.get<ProfessionalRepository>())),
        Bind((i) => ScheduleController(i.get<ProfessionalRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router('/:profession',
            child: (_, args) => SchedulePage(
                  nameOfProfession: args.params['profession'],
                )),
        Router('/time/:profession',
            child: (_, args) =>
                TimePage(nameOfProfession: args.params['profession'])),
      ];

  static Inject get to => Inject<ScheduleModule>.of();
}
