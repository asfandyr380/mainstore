import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/Banners.dart';
import 'package:main_store/View/Componants/CategoryBanners/CategoryBannersViewModel.dart';
import 'package:main_store/View/Widgets/Banners/banners.dart';
import 'package:main_store/View/Widgets/responsive.dart';
import 'package:stacked/stacked.dart';

class CategoryBanners extends StatelessWidget {
  final Function(List<Banners>) getBanner;
  CategoryBanners({required this.getBanner});
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: CategoryBannerMobile(),
      tablet: CategoryBannersWeb(getBanner: getBanner),
      desktop: CategoryBannersWeb(getBanner: getBanner),
    );
  }
}

class CategoryBannerMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BannersViewModel>.reactive(
      viewModelBuilder: () => BannersViewModel(),
      onModelReady: (model) => model.getBanners(),
      builder: (context, model, child) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < 4; i++)
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 1),
                child: BanMobile(
                  cate: model.bannerlist.isEmpty
                      ? null
                      : model
                          .bannerlist[i == 2
                              ? 4
                              : i == 3
                                  ? 5
                                  : i]
                          .cate,
                  image: model.bannerlist.isEmpty
                      ? null
                      : model
                          .bannerlist[i == 2
                              ? 4
                              : i == 3
                                  ? 5
                                  : i]
                          .image,
                  bannerText: model.bannerlist.isEmpty
                      ? null
                      : model
                          .bannerlist[i == 2
                              ? 4
                              : i == 3
                                  ? 5
                                  : i]
                          .mainText,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CategoryBannersWeb extends StatelessWidget {
  final Function(List<Banners>) getBanner;
  CategoryBannersWeb({required this.getBanner});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<BannersViewModel>.reactive(
      viewModelBuilder: () => BannersViewModel(),
      onModelReady: (model) {
        model.getBanners().then((value) {
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
                  cate: model.bannerlist.isEmpty
                      ? null
                      : model.bannerlist[0].cate,
                  image: model.bannerlist.isEmpty
                      ? null
                      : model.bannerlist[0].image,
                  bannerText: model.bannerlist.isEmpty
                      ? null
                      : model.bannerlist[0].mainText,
                ),
                Ban(
                  cate: model.bannerlist.isEmpty
                      ? null
                      : model.bannerlist[1].cate,
                  image: model.bannerlist.isEmpty
                      ? null
                      : model.bannerlist[1].image,
                  bannerText: model.bannerlist.isEmpty
                      ? null
                      : model.bannerlist[1].mainText,
                  isMiddle: true,
                ),
                Column(
                  children: [
                    SmallBanner(
                      cate: model.bannerlist.isEmpty
                          ? null
                          : model.bannerlist[4].cate,
                      image: model.bannerlist.isEmpty
                          ? null
                          : model.bannerlist[4].image,
                      bannerText: model.bannerlist.isEmpty
                          ? null
                          : model.bannerlist[4].mainText,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    SmallBanner(
                      cate: model.bannerlist.isEmpty
                          ? null
                          : model.bannerlist[5].cate,
                      image: model.bannerlist.isEmpty
                          ? null
                          : model.bannerlist[5].image,
                      bannerText: model.bannerlist.isEmpty
                          ? null
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
