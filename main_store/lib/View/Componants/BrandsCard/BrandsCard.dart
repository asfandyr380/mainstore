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
                child: brand.status == 1
                    ? BrandsCard(
                        store_name: brand.brandName!,
                        onMobile: _onMobile,
                        image: brand.image,
                        onTap: () =>
                            model.navigateToProductListing(brand.brandName!),
                      )
                    : null,
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
  final String store_name;
  final Function? onTap;
  BrandsCard({this.image, this.onMobile, this.onTap, required this.store_name});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTap!(),
        child: Container(
          height: onMobile!
              ? SizeConfig.blockSizeVertical * 6
              : SizeConfig.blockSizeVertical * 8,
          width: onMobile!
              ? SizeConfig.blockSizeHorizontal * 30
              : SizeConfig.blockSizeHorizontal * 10,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 0.5),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            child: image != ''
                ? Image(
                    fit: BoxFit.contain,
                    image: NetworkImage("$baseUrl_Image/$image"),
                  )
                : Center(child: Text(store_name)),
          ),
        ),
      ),
    );
  }
}
