import 'package:get_it/get_it.dart';
import 'package:main_store/Services/Api/Auth/Auth_Services.dart';
import 'package:main_store/Services/Api/Banners/banner_Services.dart';
import 'package:main_store/Services/Api/Cart/cart_services.dart';
import 'package:main_store/Services/Api/Category/category_services.dart';
import 'package:main_store/Services/Api/Messages/messagesServices.dart';
import 'package:main_store/Services/Api/Products/filterProducts.dart';
import 'package:main_store/Services/Api/Products/nearbyProducts.dart';
import 'package:main_store/Services/Api/Products/onSaleProducts.dart';
import 'package:main_store/Services/Api/Products/searchProducts.dart';
import 'package:main_store/Services/Api/Products/topSellingProducts.dart';
import 'package:main_store/Services/Api/Reviews/reviewsServices.dart';
import 'package:main_store/Services/Api/Wishlist/wishlist_Services.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Navigation());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BannerServices());
  locator.registerLazySingleton(() => CategoryServices());
  locator.registerLazySingleton(() => AuthServicesApi());
  locator.registerLazySingleton(() => StorageServices());
  locator.registerLazySingleton(() => OnSaleProducts());
  locator.registerLazySingleton(() => TopSelling());
  locator.registerLazySingleton(() => NearbyProduct());
  locator.registerLazySingleton(() => FilterProducts());
  locator.registerLazySingleton(() => CartService());
  locator.registerLazySingleton(() => WishServices());
  locator.registerLazySingleton(() => SearchProductServices());
  locator.registerLazySingleton(() => ReviewServices());
  locator.registerLazySingleton(() => MessageServices());
}
