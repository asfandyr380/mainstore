import 'package:get_it/get_it.dart';
import 'package:main_store/Services/Api/Auth/Auth_Services.dart';
import 'package:main_store/Services/Api/Banners/banner_Services.dart';
import 'package:main_store/Services/Api/Products/filterProducts.dart';
import 'package:main_store/Services/Api/Products/nearbyProducts.dart';
import 'package:main_store/Services/Api/Products/onSaleProducts.dart';
import 'package:main_store/Services/Api/Products/topSellingProducts.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Fireabase/Firestore/CollectionRef.dart';
import 'package:main_store/Services/Fireabase/Firestore/Wishlist_services.dart';
import 'package:main_store/Services/Fireabase/Firestore/cart_services.dart';
import 'package:main_store/Services/Fireabase/Firestore/firestore_services.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_categorys.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_products.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Navigation());
  locator.registerLazySingleton(() => Auth());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => DocCollectionRef());
  locator.registerLazySingleton(() => FirestoreServices());
  locator.registerLazySingleton(() => BannerServices());
  locator.registerLazySingleton(() => Products());
  locator.registerLazySingleton(() => GetCategorys());
  locator.registerLazySingleton(() => CartServices());
  locator.registerLazySingleton(() => WishListServices());
  locator.registerLazySingleton(() => AuthServicesApi());
  locator.registerLazySingleton(() => StorageServices());
  locator.registerLazySingleton(() => OnSaleProducts());
  locator.registerLazySingleton(() => TopSelling());
  locator.registerLazySingleton(() => NearbyProduct());
  locator.registerLazySingleton(() => FilterProducts());
}
