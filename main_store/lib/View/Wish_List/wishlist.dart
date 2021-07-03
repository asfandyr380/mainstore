import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Wish_List/wishlistViewModel.dart';
import 'package:stacked/stacked.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<WishlistViewModel>.reactive(
      viewModelBuilder: () => WishlistViewModel(),
      onModelReady: (model) => model.fetchWishlist(),
      builder: (context, model, child) => Scaffold(
        body: model.products.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Header
                    Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                        )
                      ]),
                      child: Header(),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    for (var item in model.products)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 10,
                          vertical: SizeConfig.blockSizeVertical * 2,
                        ),
                        child: WishCard(
                          details: item,
                        ),
                      ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 4,
                    ),
                    // Footer
                    Container(
                      child: Footer(),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 2,
                      )
                    ]),
                    child: Header(),
                  ),
                  // Footer
                  Container(
                    child: Footer(),
                  ),
                ],
              ),
      ),
    );
  }
}

class WishCard extends StatefulWidget {
  final ProductsModel? details;
  const WishCard({this.details});

  @override
  _WishCardState createState() => _WishCardState();
}

class _WishCardState extends State<WishCard> {
  bool hovring = false;

  mouserEnter(bool state) {
    setState(() {
      hovring = state;
    });
  }

  final nonHoverTransform = Matrix4.identity()..translate(0, 0, 0);
  final hoverTransform = Matrix4.identity()..translate(0, -10, 0);

  @override
  Widget build(BuildContext context) {
    String _name = widget.details!.name ?? '';
    double _price = widget.details!.productPrice ?? 0;
    String _image = widget.details!.images![0];
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (e) => mouserEnter(true),
      onExit: (e) => mouserEnter(false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.decelerate,
        transform: hovring ? hoverTransform : nonHoverTransform,
        width: double.infinity,
        height: SizeConfig.blockSizeVertical * 12,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: SizeConfig.blockSizeHorizontal * 6.2,
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_image),
                ),
              ),
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
            Container(
              width: SizeConfig.blockSizeHorizontal * 18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 2,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 0.5,
                  ),
                  Text(
                    '£ $_price',
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 1,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              child: CartButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class CartButton extends StatefulWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool hovring = false;

  mouserEnter(bool state) {
    setState(() {
      hovring = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (e) => mouserEnter(true),
      onExit: (e) => mouserEnter(false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 120),
        curve: Curves.easeOut,
        alignment: Alignment.center,
        width: hovring
            ? SizeConfig.blockSizeHorizontal * 12
            : SizeConfig.blockSizeHorizontal * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
          color: accentColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 3,
            )
          ],
        ),
        child: hovring
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.shoppingCart,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                  ),
                  Text(
                    'Add To Cart',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              )
            : Icon(
                FontAwesomeIcons.shoppingCart,
                color: Colors.white,
              ),
      ),
    );
  }
}
