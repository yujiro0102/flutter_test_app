import 'package:flutter/material.dart';
import 'package:flutter_test_app/components/webview_container.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'ToFlutter',
      onMessageReceived: (JavascriptMessage message) async{
        print(message.message);
        final js = 'window.\$nuxt.\$store.state.page.pageTitle';
        final webview = FlutterWebviewPlugin();
        final title = await webview.evalJavascript(js);
        print(title);
      }),
].toSet();

class AppWebview extends StatefulWidget {
  @override
  _AppWebviewState createState() => _AppWebviewState();
}

class _AppWebviewState extends State<AppWebview> {
  String _pageTitle;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pageTitle = "";
    final Widget body = WebViewContainer(
      url: 'https://naoseru-junk-frontend-dev.herokuapp.com/ja/',
      isJavascriptOn: true,
      jsChannels: jsChannels,
    );
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_pageTitle),
        ),
        body: body,
      );
  }

}
