import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:key_hash/key_hash.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _yourKeyHash = 'Unknown';
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String yourKeyHash;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      yourKeyHash = await KeyHash.getKeyHash;
    } on PlatformException {
      yourKeyHash = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _yourKeyHash = yourKeyHash;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: Column(
          children: [
            Text('$_yourKeyHash'),
            FlatButton(onPressed: loginFacebook, child: Text('Login Facebook'))
          ],
        )),
      ),
    );
  }

  loginFacebook() async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print('SUCCESS: ${result.accessToken.token}');
        // _sendTokenToServer(result.accessToken.token);
        // _showLoggedInUI();
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('FacebookLoginStatus.cancelledByUser');
        // _showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
        print('SUCCESS: ${result.errorMessage}');
        // _showErrorOnUI(result.errorMessage);
        break;
    }
  }
}
