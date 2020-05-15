class ApiConstants {
  //static const String MAIN_URL = 'http://10.0.3.2:8000/api/v1';

  static const String MAIN_URL = 'https://schedule-now.herokuapp.com/api/v1';

  static const String ALL_CLIENTS = '/clients';

  static const String REGISTER_CLIENT = '/clients';

  static const String LOGIN_URL = '/login';

  static const String ALL_SERVICES = '/services';

  static const String LOGOUT_URL = '/logout';

  static const String RECOVER_URL = '/recover';

  static const String PROFESSIONAL_BY_SERVICE = '/professional/names/';

  static const String SCHEDULED_URL = '/scheduledTime/professional?fields=time&conditions=date=';

  static const String MAKE_SCHEDULE_BY_CLIENT = '/schedule/client';

  static const String MAKE_SCHEDULE_BY_PROFESSIONAL = '/schedule/professional/'; 

  static const String RESET_TOKEN = '/refresh';

  static const String CANCEL_SCHEDULE = '/cancel';

  static const String CANCEL_SCHEDULE_PROF = '/cancel/prof';


}