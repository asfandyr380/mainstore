import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/Banners.dart';
import 'package:main_store/View/Componants/CategoryBanners/CategoryBannersViewModel.dart';
import 'package:main_store/View/Widgets/banners.dart';
import 'package:stacked/stacked.dart';

class CategoryBanners extends StatelessWidget {
  final Function(List<Banners>) getBanner;
  CategoryBanners({required this.getBanner});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<BannersViewModel>.reactive(
      viewModelBuilder: () => BannersViewModel(),
      onModelReady: (model) {
        model.fetchBanners().then((value) {
          getBanner(value);
        });
      },
      builder: (context, model, child) => Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 2,
            vertical: SizeConfig.blockSizeVertical * 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Ban(
                  image:
                      model.bannerlist.isEmpty ? '' : model.bannerlist[0].image,
                  bannerText: model.bannerlist.isEmpty
                      ? ''
                      : model.bannerlist[0].mainText,
                ),
                Ban(
                  image:
                      model.bannerlist.isEmpty ? '' : model.bannerlist[1].image,
                  bannerText: model.bannerlist.isEmpty
                      ? ''
                      : model.bannerlist[1].mainText,
                  isMiddle: true,
                ),
                Column(
                  children: [
                    SmallBanner(
                      image: model.bannerlist.isEmpty
                          ? ''
                          : model.bannerlist[4].image,
                      bannerText: model.bannerlist.isEmpty
                          ? ''
                          : model.bannerlist[4].mainText,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    SmallBanner(
                      image: model.bannerlist.isEmpty
                          ? ''
                          : model.bannerlist[5].image,
                      bannerText: model.bannerlist.isEmpty
                          ? ''
                          : model.bannerlist[5].mainText,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
