import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/snapshotCrousel.dart';
import 'package:main_store/View/ProductDetail/productDetailViewMode.dart';
import 'package:main_store/View/Widgets/custom_button.dart';
import 'package:stacked/stacked.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      viewModelBuilder: () => ProductDetailViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 9),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        height: SizeConfig.blockSizeVertical * 70,
                        width: SizeConfig.blockSizeHorizontal * 30,
                        child: SnapShotCarousel.snapShotCarousel([
                          Image.asset(
                            'assets/images/capture.png',
                          ),
                          Image.asset('assets/images/capture.png'),
                          Image.asset('assets/images/nutella.png'),
                          Image.asset('assets/images/capture.png'),
                          Image.asset('assets/images/suasages.png'),
                        ],
                            featureImageHeight:
                                SizeConfig.blockSizeVertical * 50,
                            placeholderImageHeight:
                                SizeConfig.blockSizeVertical * 10),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hershey’s Syrup',
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'By:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.blockSizeHorizontal * 1),
                          ),
                          Text(
                            'Store',
                            style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.blockSizeHorizontal * 1),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Text(
                        '£ 20.25',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 2),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 25,
                        height: SizeConfig.blockSizeVertical * 9,
                        child: Text(
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using , making it look like readable English. ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 0.8),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 5,
                        height: SizeConfig.blockSizeVertical * 5.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quantity:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 0.8),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical * 3,
                              width: SizeConfig.blockSizeHorizontal * 4.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: accentColor,
                              fixedSize: Size(
                                  SizeConfig.blockSizeHorizontal * 12,
                                  SizeConfig.blockSizeVertical * 5),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Add To Cart',
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 0.9),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: accentColor,
                              fixedSize: Size(
                                  SizeConfig.blockSizeHorizontal * 12,
                                  SizeConfig.blockSizeVertical * 5),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Buy Now',
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 0.9),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text(
                    'Description |',
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 0.9),
                  ),
                  Text(
                    ' Review',
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 0.9),
                  ),
                ],
              ),
              Divider(),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 25,
                    height: SizeConfig.blockSizeVertical * 9,
                    child: Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using , making it look like readable English. ',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
