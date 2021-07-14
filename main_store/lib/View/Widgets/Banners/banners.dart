import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Widgets/Banners/bannerViewModel.dart';
import 'package:stacked/stacked.dart';

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
                  fontWeight: FontWeight.bold,
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
class BanMobile extends StatelessWidget {
  final String? bannerText;
  final String? image;
  final String? cate;
  BanMobile({this.bannerText, this.image, this.cate});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String _bannerText = bannerText ?? '';
    String _image = image ?? placeholderBannerPic;
    String _cate = cate ?? '';
    return ViewModelBuilder<BannerViewModel>.reactive(
      viewModelBuilder: () => BannerViewModel(),
      builder: (context, model, child) => Column(
        children: [
          GestureDetector(
            onTap: () => model.navigateToProductlisting(_cate),
            child: Container(
              height: SizeConfig.blockSizeVertical * 10,
              width: SizeConfig.blockSizeHorizontal * 20,
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_image),
                ),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1),
          Container(
            width: SizeConfig.blockSizeHorizontal * 15,
            height: SizeConfig.blockSizeVertical * 5,
            child: Text(
              _bannerText,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class Ban extends StatelessWidget {
  final bool? isMiddle;
  final String? bannerText;
  final String? image;
  final String? cate;
  Ban({this.isMiddle, this.bannerText, this.image, this.cate});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isMiddle = isMiddle ?? false;
    String _bannerText = bannerText ?? '';
    String _image = image ?? placeholderBannerPic;
    String _cate = cate ?? '';
    print(cate);
    return ViewModelBuilder<BannerViewModel>.reactive(
      viewModelBuilder: () => BannerViewModel(),
      builder: (context, model, child) => Container(
        height: SizeConfig.blockSizeVertical * 60,
        width: _isMiddle
            ? SizeConfig.blockSizeHorizontal * 42
            : SizeConfig.blockSizeHorizontal * 30,
        decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              _image,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 1,
            top: SizeConfig.blockSizeVertical * 2,
          ),
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
              BannerButton(
                onPressed: () => model.navigateToProductlisting(_cate),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SmallBanner extends StatelessWidget {
  final String? bannerText;
  final String? image;
  final String? cate;
  SmallBanner({this.bannerText, this.image, this.cate});
  @override
  Widget build(BuildContext context) {
    String _cate = cate ?? '';
    SizeConfig().init(context);
    String _bannerText = bannerText ?? '';
    String _image = image ?? placeholderBannerPic;
    return ViewModelBuilder<BannerViewModel>.reactive(
      viewModelBuilder: () => BannerViewModel(),
      builder: (context, model, child) => Container(
        height: SizeConfig.blockSizeVertical * 29,
        width: SizeConfig.blockSizeHorizontal * 20,
        decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              _image,
            ),
          ),
        ),
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
              BannerButton(
                onPressed: () => model.navigateToProductlisting(_cate),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoreandMoreBanner extends StatelessWidget {
  final String? bannerText;
  final String? image;
  final Color? buttonColor;
  final Color? bannerTextColor;
  final String? cate;
  MoreandMoreBanner(
      {this.bannerText,
      this.image,
      this.buttonColor,
      this.bannerTextColor,
      this.cate});
  @override
  Widget build(BuildContext context) {
    String _bannerText = bannerText ?? '';
    String _image = image ?? placeholderBannerPic;
    Color _bannerTextColor = bannerTextColor ?? Colors.black;
    String _cate = cate ?? '';
    return ViewModelBuilder<BannerViewModel>.reactive(
      viewModelBuilder: () => BannerViewModel(),
      builder: (context, model, child) => Container(
        height: SizeConfig.blockSizeVertical * 34,
        width: SizeConfig.blockSizeHorizontal * 45,
        decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(_image),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 18,
              left: SizeConfig.blockSizeHorizontal * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 12,
                height: SizeConfig.blockSizeVertical * 5,
                child: Text(
                  _bannerText,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeHorizontal * 2,
                      color: _bannerTextColor),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              BannerButton(
                onPressed: () => model.navigateToProductlisting(_cate),
                buttonColor: buttonColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BannerButton extends StatefulWidget {
  final Color? buttonColor;
  final Function? onPressed;
  BannerButton({this.buttonColor, this.onPressed});

  @override
  _BannerButtonState createState() => _BannerButtonState();
}

class _BannerButtonState extends State<BannerButton> {
  bool hovering = false;
  final nonHoverTransform = Matrix4.identity()..translate(0, 0, 0);
  final hoverTransform = Matrix4.identity()..translate(0, -5, 0);

  mouseEnter(bool state) {
    setState(() {
      hovering = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color _buttonColor = widget.buttonColor ?? Colors.black;
    return MouseRegion(
      onEnter: (e) => mouseEnter(true),
      onExit: (e) => mouseEnter(false),
      child: Transform(
        transform: hovering ? hoverTransform : nonHoverTransform,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            animationDuration: Duration(milliseconds: 150),
            primary: accentColor,
            backgroundColor: hovering ? accentColor : null,
            side: BorderSide(
              color: accentColor,
            ),
            fixedSize: Size(
              SizeConfig.blockSizeHorizontal * 8,
              SizeConfig.blockSizeVertical * 1,
            ),
          ),
          onPressed: () => widget.onPressed!(),
          child: Text(
            'Shop Now',
            style: TextStyle(
              color: _buttonColor,
              fontSize: SizeConfig.blockSizeHorizontal * 1,
            ),
          ),
        ),
      ),
    );
  }
}
