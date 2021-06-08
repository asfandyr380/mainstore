import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/SideNav/SideNavView.dart';
import 'package:main_store/View/ProductListingPage/ProductListingPageViewModel.dart';
import 'package:main_store/View/Widgets/CardGridView.dart';
import 'package:main_store/View/Widgets/DropDown/drop_Down.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ProductListingPage extends StatelessWidget {
  const ProductListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ProductListingPageViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
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
                        child: FilterMenu(),
                      ),
                      Container(
                        child: Products(),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: FilterHeader(),
        ),
        Container(
          padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 2,
          ),
          height: SizeConfig.blockSizeVertical * 160,
          width: SizeConfig.blockSizeHorizontal * 60,
          child: CardGridView(),
        ),
      ],
    );
  }
}

class FilterHeader extends StatelessWidget {
  const FilterHeader({Key? key}) : super(key: key);

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
            child: SortBy(),
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
  const SortBy({Key? key}) : super(key: key);

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
        Dropdown(
          items: [
            'Low to High',
            'High to Low',
          ],
          dropdownVal: 'Low to High',
        ),
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
      height: SizeConfig.blockSizeVertical * 40,
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
  const FilterMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 30,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Filter',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price Filter'),
                SfRangeSlider(
                  activeColor: accentColor,
                  inactiveColor: accentColor.withOpacity(0.5),
                  min: 0,
                  max: 100,
                  values: SfRangeValues(40, 50),
                  showLabels: true,
                  onChanged: (newVal) {},
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
                  child: SideNavMenu(
                    productMenu: true,
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
