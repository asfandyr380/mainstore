import 'package:flutter/services.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/Banners.dart';
import 'package:main_store/Models/swipeBanner.dart';
import 'package:main_store/Services/Fireabase/Firestore/CollectionRef.dart';
import 'package:main_store/View/Componants/SwipeBanner/SwipeBannerView.dart';

class CategoryBanners {
  DocCollectionRef ref = locator<DocCollectionRef>();

  Future getBanners() async {
    try {
      var result = await ref.categoryBanners.get();
      if (result.docs.isNotEmpty) {
        return result.docs
            .map(
              (banner) => Banners.fromMap(
                banner.data(),
              ),
            )
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e;
    }
  }

  Future getSwipeBanners() async {
    try {
      var result = await ref.swipeBanner.get();
      if (result.docs.isNotEmpty) {
        return result.docs
            .map(
              (e) => Swipebanner.fromMap(e.data()),
            )
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }
}
