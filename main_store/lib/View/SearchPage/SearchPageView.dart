import 'package:flutter/material.dart';
import 'package:main_store/View/SearchPage/SearchPageViewModel.dart';
import 'package:stacked/stacked.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchPageViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Text('Search'),
              ),
            ),
        viewModelBuilder: () => SearchPageViewModel());
  }
}
