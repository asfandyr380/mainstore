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
            Text(
              'Fresh Mango \nDrinks',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 23),
            ),
            SizedBox(
              height: 5,
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
              style: BannerTextStyle,
            ),
            SizedBox(height: 10),
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
            Text(
              _bannerText,
              style: BannerTextStyle,
            ),
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
        padding: EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Text(
              _bannerText,
              style: BannerTextStyle,
            ),
            SizedBox(height: 10),
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
              height: 5,
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
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(
            color: accentColor,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
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
