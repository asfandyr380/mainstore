import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/Banners.dart';
import 'package:main_store/Models/ReviewModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Products/nearbyProducts.dart';
import 'package:main_store/Services/Api/Products/onSaleProducts.dart';
import 'package:main_store/Services/Api/Products/topSellingProducts.dart';
import 'package:main_store/Services/Api/Reviews/reviewsServices.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class HomeViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();
  OnSaleProducts _saleProducts = locator<OnSaleProducts>();
  TopSelling _topSelling = locator<TopSelling>();
  NearbyProduct _products = locator<NearbyProduct>();
  ReviewServices _reviewServices = locator<ReviewServices>();
  List<Banners> bannerlist = [];
  List<ReviewModel> reviewlist = [];
  var items = <ProductsModel>[];
  List<ProductsModel> onSaleProducts = [];
  List<ProductsModel> topSellingProducts = [];
  List<ProductsModel> nearbyProducts = [];
  bool isLoading = false;
  bool isNearbyloading = false;
  bool isButtonLoading = false;
  int topSaleCurrentPage = 0;
  int onSaleCurrentPage = 0;
  int nearbyCurrentPage = 0;
  int totalProducts = 0;

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  getReviews() async {
    var result = await _reviewServices.getReviews();
    if (result is List<ReviewModel>) {
      reviewlist = result;
      notifyListeners();
    }
  }

  loadMore() async {
    isButtonLoading = true;
    nearbyCurrentPage += 1;
    fetchNearbyProducts();
    isButtonLoading = false;
    notifyListeners();
  }

  navigatetodetails(ProductsModel category) {
    _navigation.navigateTo(ProductDetailsPage, arguments: category);
  }

  getBanner(List<Banners> banners) {
    bannerlist = banners;
    notifyListeners();
  }

  fetchNearbyProducts() async {
    if (!isButtonLoading) {
      isNearbyloading = true;
    }
    notifyListeners();
    var result = await _products.getProducts(nearbyCurrentPage);
    if (result is List<ProductsModel>) {
      for (var p in result) {
        nearbyProducts.add(p);
      }
      totalProducts = _products.totalProducts;
      notifyListeners();
    } else {
      print(result);
    }
    isNearbyloading = false;
    notifyListeners();
  }

  fetchTopSellingProducts() async {
    isBusy(true);
    var result = await _topSelling.getProducts(topSaleCurrentPage);
    if (result is List<ProductsModel>) {
      for (var product in result) {
        topSellingProducts.add(product);
      }
      notifyListeners();
    } else {
      print(result);
    }
    isBusy(false);
  }

  fetchOnSaleProducts() async {
    isBusy(true);
    var result = await _saleProducts.getProducts(onSaleCurrentPage);
    if (result is List<ProductsModel>) {
      for (var p in result) {
        onSaleProducts.add(p);
      }
      notifyListeners();
    } else {
      print(result);
    }
    isBusy(false);
  }
}
