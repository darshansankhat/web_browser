import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Browser_provider extends ChangeNotifier
{
  InAppWebViewController? webViewController;

  var search;

  bool a=true;

  String? copy;
}