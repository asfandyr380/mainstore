import 'package:get_it/get_it.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Fireabase/Firestore/CollectionRef.dart';
import 'package:main_store/Services/Fireabase/Firestore/Wishlist_services.dart';
import 'package:main_store/Services/Fireabase/Firestore/cart_services.dart';
import 'package:main_store/Services/Fireabase/Firestore/firestore_services.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_banners.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_categorys.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_products.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Navigation());
  locator.registerLazySingleton(() => Auth());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => DocCollectionRef());
  locator.registerLazySingleton(() => FirestoreServices());
  locator.registerLazySingleton(() => CategoryBanners());
  locator.registerLazySingleton(() => Products());
  locator.registerLazySingleton(() => GetCategorys());
  locator.registerLazySingleton(() => CartServices());
  locator.registerLazySingleton(() => WishListServices());
}
