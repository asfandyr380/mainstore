import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/swipeBanner.dart';
import 'package:main_store/View/Componants/SwipeBanner/SwipeBannerViewModel.dart';
import 'package:stacked/stacked.dart';

class SwipeBanner extends StatefulWidget {
  final bool? onMobile;
  SwipeBanner({this.onMobile});
  @override
  _SwipeBannerState createState() => _SwipeBannerState();
}

class _SwipeBannerState extends State<SwipeBanner> {
  @override
  Widget build(BuildContext context) {
    bool _onMobile = widget.onMobile ?? false;
    return ViewModelBuilder<SwipeBannerViewModel>.reactive(
      viewModelBuilder: () => SwipeBannerViewModel(),
      onModelReady: (model) {
        model.fetchBanner().then((value) {
          // if (model.list.isNotEmpty) {
          //   model.autoPlay();
          // }
        });
      },
      builder: (context, model, child) => Container(
        height: _onMobile
            ? SizeConfig.blockSizeVertical * 20
            : SizeConfig.blockSizeVertical * 45,
        width:
            _onMobile ? double.infinity : SizeConfig.blockSizeHorizontal * 75,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Stack(
          children: [
            PageView(
              controller: model.pageController,
              onPageChanged: (i) => model.onPageChange(i),
              children: [
                for (var banner in model.list)
                  BannerImage(
                    onMobile: _onMobile,
                    exploreProducts: (cate) =>
                        model.navigateToProductlisting(cate),
                    bannerDetails: banner,
                  ),
              ],
            ),
            Container(
              padding:
                  EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < model.list.length; i++)
                    PageSwipeIndicator(
                      index: i,
                      currentIndex: model.currentIndex,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerImage extends StatelessWidget {
  final Swipebanner? bannerDetails;
  final bool? onMobile;
  final Function(String)? exploreProducts;
  BannerImage({this.bannerDetails, this.exploreProducts, this.onMobile});

  @override
  Widget build(BuildContext context) {
    String _image = bannerDetails!.image ?? placeholderSwiperBannerPic;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(_image),
        ),
      ),
      child: SwipeBannerText(
        onMobile: onMobile,
        onTap: () => exploreProducts!(bannerDetails!.cate!),
        mainText: bannerDetails!.mainText ?? '',
        subText: bannerDetails!.subText ?? '',
      ),
    );
  }
}

class PageSwipeIndicator extends StatelessWidget {
  final int? index;
  final int? currentIndex;
  PageSwipeIndicator({this.index, this.currentIndex});
  @override
  Widget build(BuildContext context) {
    bool onCurrentIndex = index == currentIndex;
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 6),
      duration: Duration(milliseconds: 100),
      curve: Curves.easeOutCubic,
      height: SizeConfig.blockSizeVertical * 1.5,
      width: SizeConfig.blockSizeHorizontal * 1.5,
      decoration: BoxDecoration(
        color: onCurrentIndex ? accentColor : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class SwipeBannerText extends StatelessWidget {
  final String? mainText;
  final String? subText;
  final Function? onTap;
  final bool? onMobile;
  SwipeBannerText({this.mainText, this.subText, this.onTap, this.onMobile});
  @override
  Widget build(BuildContext context) {
    String _subText = subText ?? '';
    String _mainText = mainText ?? '';
    bool _onMobile = onMobile ?? false;
    return Container(
      child: Container(
        padding: EdgeInsets.only(
          top: _onMobile
              ? SizeConfig.blockSizeVertical * 5
              : SizeConfig.blockSizeVertical * 10,
          left: SizeConfig.blockSizeHorizontal * 3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // sub Text
            Container(
              child: Text(
                _subText,
                style: TextStyle(
                  fontSize: _onMobile
                      ? SizeConfig.blockSizeHorizontal * 2
                      : SizeConfig.blockSizeHorizontal * 1,
                ),
              ),
            ),
            // Main Body Text
            Container(
              height: _onMobile
                  ? SizeConfig.blockSizeVertical * 6
                  : SizeConfig.blockSizeVertical * 13,
              width: _onMobile
                  ? SizeConfig.blockSizeHorizontal * 35
                  : SizeConfig.blockSizeHorizontal * 20,
              child: Text(
                _mainText,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _onMobile
                      ? SizeConfig.blockSizeHorizontal * 5
                      : SizeConfig.blockSizeHorizontal * 2.5,
                ),
              ),
            ),
            SizedBox(
              height: _onMobile
                  ? SizeConfig.blockSizeVertical * 0.5
                  : SizeConfig.blockSizeVertical * 1,
            ),
            // Explore Button
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onTap!(),
                child: Container(
                  alignment: Alignment.center,
                  width: _onMobile
                      ? SizeConfig.blockSizeHorizontal * 13
                      : SizeConfig.blockSizeHorizontal * 12,
                  height: _onMobile
                      ? SizeConfig.blockSizeVertical * 2.2
                      : SizeConfig.blockSizeVertical * 5,
                  decoration: BoxDecoration(
                    color: accentColor,
                  ),
                  child: Text(
                    'Explore Products',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _onMobile
                          ? SizeConfig.blockSizeHorizontal * 1.5
                          : SizeConfig.blockSizeHorizontal * 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
