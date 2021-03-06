import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:miro_voice_memos/modules/2oauth/2oauth.dart';
import '../../modules/2oauth/2oauth_cfg.dart';
import '../../utils/Utils.dart';

class MiroOauthScreen extends StatefulWidget {
  @override
  _MiroOauthScreenState createState() => _MiroOauthScreenState();
}

class _MiroOauthScreenState extends State<MiroOauthScreen> {
  var clientId = oauthCfg['CLIENT_ID'];
  var baseUrl = oauthCfg['BASE_URL'];
  var authorized = false;

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  var code;

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  getTokenFormCode(url, baseUrl) async {
    if (url.startsWith(baseUrl)) {
      RegExp regExp = new RegExp("code=(.*?)&");
      this.code = regExp.firstMatch(url)?.group(1);
      var token = await getTokenFromCode(code);
      if (token != null) {
        flutterWebviewPlugin.close();
        Navigator.pushNamedAndRemoveUntil(context, '/boards', (_) => false);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print("onStateChanged: ${state.type} ${state.url}");
    });

    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print('changed ' + url);
      if (authorized != true) {
        setState(() {
          getTokenFormCode(url, baseUrl);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String loginUrl =
        "https://miro.com/oauth/authorize?response_type=code&client_id=$clientId&redirect_uri=$baseUrl/oauth";

    print(loginUrl);
    return new WebviewScaffold(
        url: loginUrl,
        hidden: true,
        initialChild: Center(
            child: SpinKitWave(
          size: MediaQuery.of(context).size.height * 0.07,
          color: Utils.accentColor,
        )),
        appBar: new AppBar(
          bottomOpacity: 0.0,
          title: Text('miro logging in'),
        ));
  }
}
