import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_user_agent/flutter_user_agent.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({
    this.url,
    this.isJavascriptOn,
    this.jsChannels,
  });
  final String url;
  final bool isJavascriptOn;
  final Set<JavascriptChannel> jsChannels;
  @override
  _WebViewContainerState createState() => _WebViewContainerState();
}
class _WebViewContainerState extends State<WebViewContainer> {
  String _webUserAgent = '<unknown>';
  Future<void> initUserAgentState() async {
    String  webViewUserAgent;
    await FlutterUserAgent.init();
    webViewUserAgent = FlutterUserAgent.webViewUserAgent;
    if (!mounted) {
      return;
    }
    setState(() {
      _webUserAgent = webViewUserAgent;
    });
  }
  @override
  void initState() {
    super.initState();
    initUserAgentState();
  }
  @override
  Widget build(BuildContext context) {
    final _webViewItem = WebviewScaffold(
      url: widget.url,
      withJavascript: widget.isJavascriptOn,
      hidden: false,
      javascriptChannels: widget.jsChannels,
      userAgent: '$_webUserAgent naoseru-mobile/1.0.0',
    );
    return _webViewItem;
  }
}
