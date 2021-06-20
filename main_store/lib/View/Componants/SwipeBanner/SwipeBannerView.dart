import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/swipeBanner.dart';
import 'package:main_store/View/Componants/SwipeBanner/SwipeBannerViewModel.dart';
import 'package:stacked/stacked.dart';

class SwipeBanner extends StatefulWidget {
  @override
  _SwipeBannerState createState() => _SwipeBannerState();
}

class _SwipeBannerState extends State<SwipeBanner> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SwipeBannerViewModel>.reactive(
      viewModelBuilder: () => SwipeBannerViewModel(),
      onModelReady: (model) {
        model.fetchBanner().then((value) {
          if (model.list.isNotEmpty) {
            model.autoPlay(_pageController);
          }
        });
      },
      builder: (context, model, child) => Container(
        height: SizeConfig.blockSizeVertical * 45,
        width: SizeConfig.blockSizeHorizontal * 75,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (i) => model.onPageChange(i),
              children: [
                for (var banner in model.list)
                  BannerImage(
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
  BannerImage({this.bannerDetails});

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

  SwipeBannerText({this.mainText, this.subText});
  @override
  Widget build(BuildContext context) {
    String _subText = subText ?? '';
    String _mainText = mainText ?? '';
    return Container(
      child: Container(
        padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 10,
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
                  fontSize: SizeConfig.blockSizeHorizontal * 1,
                ),
              ),
            ),
            // Main Body Text
            Container(
              height: SizeConfig.blockSizeVertical * 13,
              width: SizeConfig.blockSizeHorizontal * 20,
              child: Text(
                _mainText,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            // Explore Button
            Container(
              child: Container(
                alignment: Alignment.center,
                width: SizeConfig.blockSizeHorizontal * 12,
                height: SizeConfig.blockSizeVertical * 5,
                decoration: BoxDecoration(
                  color: accentColor,
                ),
                child: Text(
                  'Explore Products',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.blockSizeHorizontal * 1,
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
