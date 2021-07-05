import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/BrandsCard/BrandsCardViewModel.dart';
import 'package:stacked/stacked.dart';

class BrandsRow extends StatelessWidget {
  const BrandsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BrandCardViewModel>.reactive(
      onModelReady: (model) => model.fetchBrands(),
      builder: (context, model, child) => SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var brand in model.brandslits)
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1,
                  horizontal: SizeConfig.blockSizeHorizontal * 1,
                ),
                child: BrandsCard(
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
  BrandsCard({this.image});
  @override
  Widget build(BuildContext context) {
    String _image = image ?? placeholderBrandPic;
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.blockSizeVertical * 8,
      width: SizeConfig.blockSizeHorizontal * 10,
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
