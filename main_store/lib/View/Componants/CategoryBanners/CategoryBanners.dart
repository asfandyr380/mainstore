import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

class CategoryBanners extends StatelessWidget {
  final bool? isMiddle;
  final String? bannerText;
  CategoryBanners({this.isMiddle, this.bannerText});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isMiddle = isMiddle ?? false;
    String _bannerText = bannerText ?? '';
    return Container(
      height: SizeConfig.blockSizeVertical * 55,
      width: _isMiddle
          ? SizeConfig.blockSizeHorizontal * 25
          : SizeConfig.blockSizeHorizontal * 20,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 1,
          top: SizeConfig.blockSizeVertical * 2,
        ),
        // TODO: Add Image From the Back-End Here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_bannerText),
            SizedBox(
              height: 10,
            ),
            BannerButton()
          ],
        ),
      ),
    );
  }
}

class CategoryBannersSmall extends StatelessWidget {
  final String? bannerText;
  CategoryBannersSmall({this.bannerText});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String _bannerText = bannerText ?? '';
    return Container(
      height: SizeConfig.blockSizeVertical * 25,
      width: SizeConfig.blockSizeHorizontal * 18,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      // TODO: Add Image From the Back-End Here
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Text(_bannerText),
            SizedBox(height: 10),
            BannerButton(),
          ],
        ),
      ),
    );
  }
}

class BannerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(
            color: accentColor,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      onPressed: () {},
      child: Text(
        'Shop Now',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
