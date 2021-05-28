import 'package:get_it/get_it.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Navigation());
  locator.registerLazySingleton(() => Auth());
}
