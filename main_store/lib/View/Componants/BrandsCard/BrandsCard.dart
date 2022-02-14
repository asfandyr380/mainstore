import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/BrandsCard/BrandsCardViewModel.dart';
import 'package:stacked/stacked.dart';

enum BrandCardViewType { desktop, mobile }

class BrandsRow extends StatelessWidget {
  final BrandCardViewType type;
  const BrandsRow({required this.type});

  @override
  Widget build(BuildContext context) {
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
                    ? _brandCard(
                        type: type,
                        store_name: brand.brandName!,
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

Widget _brandCard({
  String? image,
  required BrandCardViewType type,
  required String store_name,
  required Function onTap,
}) {
  switch (type) {
    case BrandCardViewType.desktop:
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => onTap(),
          child: Container(
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

    case BrandCardViewType.mobile:
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => onTap(),
          child: Container(
            height: SizeConfig.blockSizeVertical * 6,
            width: SizeConfig.blockSizeHorizontal * 30,
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
