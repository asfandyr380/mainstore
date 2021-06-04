import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

class DiscountBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.blockSizeVertical * 34,
      width: SizeConfig.blockSizeHorizontal * 64,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Container(
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 5,
            left: SizeConfig.blockSizeHorizontal * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Upto '),
                Text(
                  '50% ',
                  style: TextStyle(color: accentColor),
                ),
                Text('Off'),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 12,
              height: SizeConfig.blockSizeVertical * 10,
              child: Text(
                'Fresh Mango Drinks',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.blockSizeHorizontal * 2,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            BannerButton()
          ],
        ),
      ),
    );
  }
}

class SecondBanner extends StatelessWidget {
  final String? bannerText;
  SecondBanner({this.bannerText});
  @override
  Widget build(BuildContext context) {
    String _bannerText = bannerText ?? '';
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.blockSizeVertical * 70,
      width: SizeConfig.blockSizeHorizontal * 30,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      // TODO: Add Image From the Back-End Here
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Text(
              _bannerText,
              style: BannerTextStyle.copyWith(
                fontSize: SizeConfig.blockSizeHorizontal * 2,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            BannerButton(),
          ],
        ),
      ),
    );
  }
}

// Banner
class Ban extends StatelessWidget {
  final bool? isMiddle;
  final String? bannerText;
  Ban({this.isMiddle, this.bannerText});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isMiddle = isMiddle ?? false;
    String _bannerText = bannerText ?? '';
    return Container(
      height: SizeConfig.blockSizeVertical * 60,
      width: _isMiddle
          ? SizeConfig.blockSizeHorizontal * 42
          : SizeConfig.blockSizeHorizontal * 30,
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
            Container(
              width: SizeConfig.blockSizeHorizontal * 12,
              height: SizeConfig.blockSizeVertical * 10,
              child: Text(
                _bannerText,
                textAlign: TextAlign.start,
                style: BannerTextStyle.copyWith(
                  fontSize: SizeConfig.blockSizeHorizontal * 2,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            BannerButton()
          ],
        ),
      ),
    );
  }
}

class SmallBanner extends StatelessWidget {
  final String? bannerText;
  SmallBanner({this.bannerText});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String _bannerText = bannerText ?? '';
    return Container(
      height: SizeConfig.blockSizeVertical * 29,
      width: SizeConfig.blockSizeHorizontal * 20,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      // TODO: Add Image From the Back-End Here
      child: Padding(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
        child: Column(
          children: [
            Text(
              _bannerText,
              style: BannerTextStyle.copyWith(
                fontSize: SizeConfig.blockSizeHorizontal * 2,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 1),
            BannerButton(),
          ],
        ),
      ),
    );
  }
}

class MoreandMoreBanner extends StatelessWidget {
  final String? bannerText;
  MoreandMoreBanner({this.bannerText});
  @override
  Widget build(BuildContext context) {
    String _bannerText = bannerText ?? '';
    return Container(
      height: SizeConfig.blockSizeVertical * 34,
      width: SizeConfig.blockSizeHorizontal * 45,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Container(
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 5,
            left: SizeConfig.blockSizeHorizontal * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _bannerText,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 23),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            BannerButton()
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
      style: OutlinedButton.styleFrom(
        primary: accentColor,
        side: BorderSide(
          color: accentColor,
        ),
        fixedSize: Size(
          SizeConfig.blockSizeHorizontal * 8,
          SizeConfig.blockSizeVertical * 1,
        ),
      ),
      onPressed: () {},
      child: Text(
        'Shop Now',
        style: TextStyle(
          color: Colors.black,
          fontSize: SizeConfig.blockSizeHorizontal * 1,
        ),
      ),
    );
  }
}