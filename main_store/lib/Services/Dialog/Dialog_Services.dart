import 'dart:async';

import 'package:main_store/Models/AlertRequest.dart';

class DialogService {
  late Function(AlertRequest) _showDialogListener;
  late Completer<AlertResponse>? _dialogCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<AlertResponse> showDialog(
      {required String title,
      required String description,
      required String buttonTitle}) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(AlertRequest(
        title: title, description: description, buttonTitle: buttonTitle));
    return _dialogCompleter!.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(AlertResponse response) {
    _dialogCompleter!.complete(response);
    _dialogCompleter = null;
  }
}
