import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/categoryModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/SideNav/SideNavView.dart';
import 'package:main_store/View/ProductListingPage/ProductListingPageViewModel.dart';
import 'package:main_store/View/Widgets/CardGrid/CardGridView.dart';
import 'package:main_store/View/Widgets/DropDown/drop_Down.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ProductListingPage extends StatelessWidget {
  final List<String>? cate;
  ProductListingPage({this.cate});

  @override
  Widget build(BuildContext context) {
    List<String> _cate = cate ?? [];
    SizeConfig().init(context);
    return ViewModelBuilder<ProductListingPageViewModel>.reactive(
      viewModelBuilder: () => ProductListingPageViewModel(),
      onModelReady: (model) => model.fetchProductByFilter(_cate),
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

class Products extends StatelessWidget {
  final List<ProductsModel>? details;
  final Function? orderBy;
  final bool? isBusy;
  Products({this.details, this.orderBy, this.isBusy});

  @override
  Widget build(BuildContext context) {
    bool _isBusy = isBusy ?? false;
    return Column(
      children: [
        Container(
          child: FilterHeader(orderBy: (val) => orderBy!(val)),
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
  FilterHeader({this.orderBy});
  @override
  Widget build(BuildContext context) {
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
                    '1 ',
                    style: TextStyle(
                      color: accentColor,
                    ),
                  ),
                ),
                Container(
                  child: Text('of 5'),
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
                title: Text(c.cateName!),
                textColor: accentColor,
                iconColor: accentColor,
                children: [
                  for (var sub in c.subCategory)
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
