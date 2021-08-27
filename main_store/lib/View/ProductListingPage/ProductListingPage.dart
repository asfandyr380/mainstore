import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/ProductListingPage/ProductListingPageViewModel.dart';
import 'package:main_store/View/Widgets/CardGrid/CardGridView.dart';
import 'package:main_store/View/Widgets/DropDown/drop_Down.dart';
import 'package:main_store/View/Widgets/Mobile_AppBar.dart';
import 'package:main_store/View/Widgets/ProductCard/productListingCard.dart';
import 'package:main_store/View/Widgets/responsive.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ListingPage extends StatelessWidget {
  final dynamic cate;
  ListingPage({this.cate});
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: ListingPageMobile(cate: cate is String ? [] : cate),
      tablet: ProductListingPage(
        cate: cate,
      ),
      desktop: ProductListingPage(cate: cate),
    );
  }
}

class ProductListingPage extends StatelessWidget {
  final dynamic cate;
  ProductListingPage({this.cate});

  @override
  Widget build(BuildContext context) {
    // List<String> _cate = cate ?? [];
    SizeConfig().init(context);
    return ViewModelBuilder<ProductListingPageViewModel>.reactive(
      viewModelBuilder: () => ProductListingPageViewModel(),
      onModelReady: (model) {
        if (cate is List<String>) {
          model.fetchProductByFilter(cate);
        } else if (cate == null) {
          model.fetchProductByFilter([]);
        } else {
          model.filterByStore(cate);
        }
      },
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                  )
                ]),
                child: Header(),
              ),
              Banner(),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 3,
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: FilterMenu(
                          state: model.selectState,
                          value: model.range,
                          onSliderChange: (val) => model.onChange(val),
                          onTap: (cate) {
                            model.byCategory(cate);
                          },
                        ),
                      ),
                      Container(
                        child: Products(
                          currentPage: model.currentPage,
                          totalCount: model.totalCount,
                          isBusy: model.isLoading,
                          details: model.byRange
                              ? model.filterlist
                              : model.productList,
                          orderBy: (val) => model.orderBy(val),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 10; i++)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Pagination(
                          textColor: model.currentPage == i
                              ? Colors.white
                              : Colors.black,
                          color: model.currentPage == i
                              ? accentColor
                              : footerColor,
                          count: i,
                          selectPage: (page) => model.changePage(page),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              // Footer
              Container(
                child: Footer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Pagination extends StatelessWidget {
  final int? count;
  final Function(int)? selectPage;
  final Color? color;
  final Color? textColor;
  Pagination({this.count, this.selectPage, this.color, this.textColor});
  @override
  Widget build(BuildContext context) {
    int _count = count ?? 0;
    return GestureDetector(
      onTap: () => selectPage!(_count),
      child: Container(
        alignment: Alignment.center,
        height: SizeConfig.blockSizeVertical * 3,
        width: SizeConfig.blockSizeHorizontal * 2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          '${_count + 1}',
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

class Products extends StatelessWidget {
  final List<ProductsModel>? details;
  final Function? orderBy;
  final bool? isBusy;
  final int? totalCount;
  final int? currentPage;
  Products(
      {this.details,
      this.orderBy,
      this.isBusy,
      this.currentPage,
      this.totalCount});

  @override
  Widget build(BuildContext context) {
    bool _isBusy = isBusy ?? false;
    return Column(
      children: [
        Container(
          child: FilterHeader(
            orderBy: (val) => orderBy!(val),
            totalCount: totalCount,
            currentPage: currentPage,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 2,
          ),
          height: SizeConfig.blockSizeVertical * 160,
          width: SizeConfig.blockSizeHorizontal * 70,
          child: !_isBusy
              ? CardGridView(
                  productDetails: details,
                  crossAxixCount: 4,
                )
              : Container(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator(color: accentColor)),
        ),
      ],
    );
  }
}

class FilterHeader extends StatelessWidget {
  final Function(String)? orderBy;
  final int? totalCount;
  final int? currentPage;
  FilterHeader({this.orderBy, this.currentPage, this.totalCount});
  @override
  Widget build(BuildContext context) {
    int _totalCount = totalCount ?? 0;
    int _currentPage = currentPage ?? 0;
    return Container(
      height: SizeConfig.blockSizeVertical * 5,
      width: SizeConfig.blockSizeHorizontal * 60,
      decoration: BoxDecoration(
        color: footerColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 1,
            ),
            child: SortBy(
              orderBy: (val) => orderBy!(val),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              right: SizeConfig.blockSizeHorizontal * 1,
            ),
            child: Row(
              children: [
                Container(
                  child: Text(
                    'Showing  Page ',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '${_currentPage + 1} ',
                    style: TextStyle(
                      color: accentColor,
                    ),
                  ),
                ),
                Container(
                  child: Text('of $_totalCount'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SortBy extends StatelessWidget {
  final Function(String)? orderBy;
  SortBy({this.orderBy});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Text(
            'Sort By:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.blockSizeHorizontal * 1.5,
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 1,
        ),
        Dropdown(items: [
          'Low to High',
          'High to Low',
        ], orderBy: (val) => orderBy!(val)),
      ],
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.blockSizeVertical * 20,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/grocery_demographics_banner.png',
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text(
              'General Grocery',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 3,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterMenu extends StatelessWidget {
  final SfRangeValues? value;
  final Function(SfRangeValues)? onSliderChange;
  final Function(List)? onTap;
  final bool? state;
  const FilterMenu({this.value, this.onSliderChange, this.onTap, this.state});

  @override
  Widget build(BuildContext context) {
    SfRangeValues _values = value ?? SfRangeValues(0, 100);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 20,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Filter',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price Filter'),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 20,
                  child: SfRangeSlider(
                    activeColor: accentColor,
                    inactiveColor: accentColor.withOpacity(0.5),
                    min: 0,
                    max: 100,
                    enableTooltip: true,
                    numberFormat: NumberFormat('£'),
                    values: _values,
                    showLabels: true,
                    onChanged: (newVal) => onSliderChange!(newVal),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Filter By Category',
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: CategoryFilterMenu(
                    onSelect: (cate) => onTap!(cate),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryFilterMenu extends StatefulWidget {
  final Function(List)? onSelect;

  CategoryFilterMenu({this.onSelect});

  @override
  _CategoryFilterMenuState createState() => _CategoryFilterMenuState();
}

class _CategoryFilterMenuState extends State<CategoryFilterMenu> {
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );

  @override
  void initState() {
    super.initState();
    multipleCheckController.listen((data) {
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductListingPageViewModel>.reactive(
      viewModelBuilder: () => ProductListingPageViewModel(),
      onModelReady: (model) => model.fetchCategorys(),
      builder: (context, model, child) => Container(
        child: Column(
          children: [
            for (var c in model.catelist)
              ExpansionTile(
                title: Text(c.mainCate!),
                textColor: accentColor,
                iconColor: accentColor,
                children: [
                  for (var sub in c.superCate)
                    SimpleGroupedCheckbox<String>(
                      controller: multipleCheckController,
                      itemsTitle: sub.subCate!,
                      values: sub.subCate!,
                      activeColor: accentColor,
                      groupTitle: sub.cateName,
                      checkFirstElement: false,
                      helperGroupTitle: true,
                      onItemSelected: (data) {
                        // print(data);
                        widget.onSelect!(data);
                      },
                      isExpandableTitle: sub.subCate!.isEmpty ? false : true,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ListingPageMobile extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String>? cate;
  ListingPageMobile({this.cate});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductListingPageViewModel>.reactive(
      viewModelBuilder: () => ProductListingPageViewModel(),
      onModelReady: (model) => model.fetchProductByFilter(cate),
      builder: (ctx, model, child) => Scaffold(
        appBar: mobileAppBar(scaffoldKey),
        body: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.blockSizeVertical * 2,
                      ),
                      child: Text('Results For: General Grocerey')),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 2),
                    child: Icon(FontAwesomeIcons.filter,
                        size: SizeConfig.blockSizeHorizontal * 4),
                  ),
                ],
              ),
              model.isLoading
                  ? Container(
                      child: CircularProgressIndicator(
                        color: accentColor,
                      ),
                    )
                  : Container(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: model.productList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, i) {
                          return ProductCardMobile(
                            details: model.byRange
                                ? model.filterlist[i]
                                : model.productList[i],
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
