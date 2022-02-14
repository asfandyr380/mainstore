import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:velocity_x/velocity_x.dart';

class CartFavandSignupLoginRow extends StatefulWidget {
  final Function(String) onTap;
  final bool userLogedIn;
  final Function onCartPressed;
  final int cartCount;
  final int wishCount;
  final Function goToWishList;
  CartFavandSignupLoginRow({
    required this.onTap,
    required this.userLogedIn,
    required this.onCartPressed,
    required this.cartCount,
    required this.wishCount,
    required this.goToWishList,
  });

  @override
  State<CartFavandSignupLoginRow> createState() =>
      _CartFavandSignupLoginRowState();
}

class _CartFavandSignupLoginRowState extends State<CartFavandSignupLoginRow> {
  Widget _indexIndicator({int count: 0}) {
    return Container(
      alignment: Alignment.center,
      height: context.percentHeight * 2.4,
      width: context.percentWidth * 2.4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accentColor,
      ),
      child: Text(
        '$count',
        style: TextStyle(
          fontSize: context.percentWidth * 0.6,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
                child: !widget.userLogedIn
                    ? GestureDetector(
                        onTap: () => widget.onTap(''),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(fontSize: context.percentWidth * 1),
                        ),
                      )
                    : PopupMenuButton<String>(
                        icon: CircleAvatar(
                          backgroundColor: accentColor,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        onSelected: (_) => widget.onTap(_),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem<String>(
                              value: "1",
                              child: Text('Dashboard'),
                            ),
                            PopupMenuItem<String>(
                              value: "2",
                              child: Text(
                                'Sign Out',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ];
                        },
                      )),
          ),
          SizedBox(
            width: context.percentWidth * 0.8,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => widget.goToWishList(),
                    icon: Icon(
                      FontAwesomeIcons.heart,
                      size: context.percentWidth * 2,
                    ),
                  ),
                  _indexIndicator(count: widget.wishCount),
                ],
              ),
            ),
          ),
          SizedBox(
            width: context.percentWidth * 0.8,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => widget.onCartPressed(),
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      size: context.percentWidth * 2,
                    ),
                  ),

                  _indexIndicator(
                    count: widget.cartCount,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
