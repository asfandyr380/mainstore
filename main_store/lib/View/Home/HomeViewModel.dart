import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:map_picker/map_picker.dart';

class HomeViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();
  OnSaleProducts _saleProducts = locator<OnSaleProducts>();
  TopSelling _topSelling = locator<TopSelling>();
  NearbyProduct _products = locator<NearbyProduct>();
  ReviewServices _reviewServices = locator<ReviewServices>();
  List<Banners> bannerlist = [
    Banners(
        id: 1,
        image: "img_banner4-1-new.jpeg",
        mainText: "Fruits & Dried Fruits"),
    Banners(
        id: 2,
        image: "global-grocery-items-counter-ad0653ad.jpeg",
        mainText: "Grocery Items"),
    Banners(id: 3, image: "cosmetics.png", mainText: "Cosmetics"),
    Banners(id: 4, image: "frozenmeat.png", mainText: "Frozen Meat"),
    Banners(id: 5, image: "img_banner4-3-new.jpeg", mainText: "Fresh Bread"),
    Banners(id: 6, image: "img_banner4-4-new.jpeg", mainText: "Fish & SeaFood"),
  ];

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
  int totalProducts = 0;
  int totalPage = 0;
  int currentProductOffset = 0;
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  setBusy(bool state) {
    isButtonLoading = state;
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
    currentProductOffset += 15;
    setBusy(true);
    fetchNearbyProducts();
    setBusy(false);
  }

  navigatetodetails(ProductsModel category) {
    _navigation.navigateTo(ProductDetailsPage, arguments: category);
  }

  // getBanner(List<Banners> banners) {
  //   bannerlist = banners;
  //   notifyListeners();
  // }

  fetchNearbyProducts() async {
    var result = await _products.getProducts(currentProductOffset);
    if (result is List<ProductsModel>) {
      for (var p in result) {
        nearbyProducts.add(p);
      }
      totalProducts = _products.totalProducts;
      totalPage = _products.totalPage;
      currentProductOffset = _products.currentProduct;
      notifyListeners();
    } else {
      print(result);
    }
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

  // Initialize Everything Here
  init(BuildContext context) async {
    fetchOnSaleProducts();
    fetchTopSellingProducts();
    fetchNearbyProducts();
    getReviews();
    // Future.delayed(Duration(seconds: 5), () {
    //   showLocationPicker(context);
    // });
  }

  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(41.311158, 69.279737),
    zoom: 14.4746,
  );

  showLocationPicker(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (_) {
          return AlertDialog(
            title: Text("Location Picker"),
            content: SizedBox(
              height: 200,
              width: 200,
              child: MapPicker(
                // pass icon widget
                iconWidget: Icon(Icons.location_on_rounded),
                //add map picker controller
                mapPickerController: mapPickerController,
                child: GoogleMap(
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  // hide location button
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  //  camera position
                  initialCameraPosition: cameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onCameraMoveStarted: () {
                    // notify map is moving
                    mapPickerController.mapMoving!();
                  },
                  onCameraMove: (cameraPosition) {
                    this.cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () async {
                    // notify map stopped moving
                    mapPickerController.mapFinishedMoving!();
                  },
                ),
              ),
            ),
          );
        });
  }

  disposeStuff() {}
}
