import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Widgets/banners.dart';

class CategoryBanners extends StatelessWidget {
  final String? bannerText;
  CategoryBanners({this.bannerText});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String _bannerText = bannerText ?? '';
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 2,
          vertical: SizeConfig.blockSizeVertical * 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Ban(
                bannerText: 'Fruits & Dreid Fruits',
              ),
              Ban(
                bannerText: 'Fresh Vagitables',
                isMiddle: true,
              ),
              Column(
                children: [
                  SmallBanner(
                    bannerText: 'Fresh Bread',
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  SmallBanner(
                    bannerText: 'Fish & SeaFood',
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: SecondBanner(
                  bannerText: 'Fresh Fruits',
                ),
              ),
              Column(
                children: [
                  DiscountBanner(),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  DiscountBanner(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
