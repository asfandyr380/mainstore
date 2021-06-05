import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/AlertRequest.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({required this.child});

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  void _showDialog(AlertRequest req) {
    Alert(
        context: context,
        title: req.title,
        desc: req.description,
        closeFunction: () {
          _dialogService.dialogComplete(AlertResponse(confirmed: false));
          Navigator.of(context).pop();
        },
        buttons: [
          DialogButton(
            color: accentColor,
            child: Text(
              req.buttonTitle,
              style: TextStyle(fontSize: 21),
            ),
            onPressed: () {
              _dialogService.dialogComplete(AlertResponse(confirmed: true));
              Navigator.of(context).pop();
            },
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
