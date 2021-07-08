import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Products/searchProducts.dart';
import 'package:main_store/View/Home/HomeView.dart';
import 'package:main_store/View/Widgets/SearchWidget/SearchViewModel.dart';
import 'package:stacked/stacked.dart';

class SearchBarRow extends StatefulWidget {
  @override
  _SearchBarRowState createState() => _SearchBarRowState();
}

class _SearchBarRowState extends State<SearchBarRow> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(),
      builder: (contex, model, child) => Container(
        child: Row(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 5,
              width: SizeConfig.blockSizeHorizontal * 40,
              child: TypeAheadField(
                hideOnEmpty: true,
                hideOnError: true,
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(fontStyle: FontStyle.italic),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 0.5,
                        left: SizeConfig.blockSizeHorizontal * 1),
                    hintText: 'Search Product',
                    hintStyle: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 1,
                      color: Color(0xFF959595),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        topLeft: Radius.circular(18),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: accentColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        topLeft: Radius.circular(18),
                      ),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  return await model.search(pattern.toLowerCase());
                },
                itemBuilder: (context, result) {
                  ProductsModel m = result as ProductsModel;
                  return ListTile(
                    leading: Container(
                        child: Image(
                      image: NetworkImage(m.images![0]),
                    )),
                    title: Text('${m.name}'),
                    subtitle: Text('\$${m.productPrice}'),
                  );
                },
                onSuggestionSelected: (result) {
                  ProductsModel m = result as ProductsModel;
                  model.navigatetodetails(m);
                },
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 5,
              width: SizeConfig.blockSizeHorizontal * 5,
              child: Icon(
                FontAwesomeIcons.search,
                color: Colors.white,
                size: SizeConfig.blockSizeHorizontal * 1,
              ),
              decoration: BoxDecoration(
                color: Color(0xff40a944),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchProductServices _services = locator<SearchProductServices>();

  Future<List> search(String key) async {
    List<ProductsModel> result = await _services.seaerhForProduct(key);
    print(result);
    return result.map((e) {
      print(e.name);
      Map<String, dynamic> obj = {
        'name': e.name,
        'price': e.productPrice,
        'image': e.images![0]
      };
      return obj;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: InputDecoration(border: OutlineInputBorder())),
          suggestionsCallback: (pattern) async {
            return await search(pattern.toLowerCase());
          },
          itemBuilder: (context, result) {
            Map<String, dynamic> m = result as Map<String, dynamic>;
            return ListTile(
              leading: Container(
                  child: Image(
                image: NetworkImage(m['image']),
              )),
              title: Text('${m['name']}'),
              subtitle: Text('\$${m['price']}'),
            );
          },
          onSuggestionSelected: (suggestion) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Home()));
          },
        ),
      ),
    );
  }
}
