import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/CategoryBanners/CategoryBannersViewModel.dart';
import 'package:main_store/View/Widgets/Banners/banners.dart';
import 'package:stacked/stacked.dart';

enum CategoryBannerType { desktop, mobile }

class CategoryBanners extends StatelessWidget {
  final CategoryBannerType type;
  CategoryBanners({required this.type});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<BannersViewModel>.reactive(
      viewModelBuilder: () => BannersViewModel(),
      builder: (context, model, child) {
        switch (type) {
          case CategoryBannerType.desktop:
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BannerView(
                        type: BannersViewType.medium,
                        cate: model.bannerlist[0].cate,
                        image: model.bannerlist[0].image,
                        bannerText: model.bannerlist[0].mainText,
                      ),
                      BannerView(
                        type: BannersViewType.large,
                        cate: model.bannerlist[1].cate,
                        image: model.bannerlist[1].image,
                        bannerText: model.bannerlist[1].mainText,
                      ),
                      Column(
                        children: [
                          BannerView(
                            type: BannersViewType.small,
                            cate: model.bannerlist[4].cate,
                            image: model.bannerlist[4].image,
                            bannerText: model.bannerlist[4].mainText,
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          BannerView(
                            type: BannersViewType.small,
                            cate: model.bannerlist[5].cate,
                            image: model.bannerlist[5].image,
                            bannerText: model.bannerlist[5].mainText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );

          case CategoryBannerType.mobile:
            return SingleChildScrollView(
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
                        cate: model
                            .bannerlist[i == 2
                                ? 4
                                : i == 3
                                    ? 5
                                    : i]
                            .cate,
                        image: model
                            .bannerlist[i == 2
                                ? 4
                                : i == 3
                                    ? 5
                                    : i]
                            .image,
                        bannerText: model
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
            );
        }
      },
    );
  }
}
