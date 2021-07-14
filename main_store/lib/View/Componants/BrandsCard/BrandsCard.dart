import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/BrandsCard/BrandsCardViewModel.dart';
import 'package:stacked/stacked.dart';

class BrandsRow extends StatelessWidget {
  final bool? onMobile;
  const BrandsRow({this.onMobile});

  @override
  Widget build(BuildContext context) {
    bool _onMobile = onMobile ?? false;
    return ViewModelBuilder<BrandCardViewModel>.reactive(
      onModelReady: (model) => model.fetchBrands(),
      builder: (context, model, child) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var brand in model.brandslits)
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1,
                  horizontal: SizeConfig.blockSizeHorizontal * 1,
                ),
                child: BrandsCard(
                  onMobile: _onMobile,
                  image: brand.image,
                ),
              ),
          ],
        ),
      ),
      viewModelBuilder: () => BrandCardViewModel(),
    );
  }
}

class BrandsCard extends StatelessWidget {
  final String? image;
  final bool? onMobile;
  BrandsCard({this.image, this.onMobile});
  @override
  Widget build(BuildContext context) {
    String _image = image ?? placeholderBrandPic;
    SizeConfig().init(context);
    return Container(
      height: onMobile!
          ? SizeConfig.blockSizeVertical * 4
          : SizeConfig.blockSizeVertical * 8,
      width: onMobile!
          ? SizeConfig.blockSizeHorizontal * 17
          : SizeConfig.blockSizeHorizontal * 10,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 0.5),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Image(
          fit: BoxFit.contain,
          image: NetworkImage(_image),
        ),
      ),
    );
  }
}
