### Lấy keyhash project
Dùng plugin này để lấy keyhash
```yaml
key_hash: ^0.0.1
```
Sử dụng lệnh để lấy keyhash sau đó có thể bỏ plugin đi
```dart
yourKeyHash = await KeyHash.getKeyHash;
```
Sau khi có keyhash thì add vào cài đặt của project trên FacebookForDevelopers
### Thêm plugin Flutter Facebook Login
```yaml
flutter_facebook_login: ^3.0.0
```
Trong dự án Android **<your project root>/android/app/src/main/res/values/strings.xml**(chưa có thì tạo file **strings.xml**)

Rồi thêm nhưng thông tin sau từ FacebookForDevelopers vào file xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">000000000000.</string>
    <!-- Thay "000000000000" bằng mã App Facebook của ban. -->
    <string name="facebook_app_id">Mã dự án</string>
    <!--
      Thay "000000000000" bằng mã App Facebook của ban.
      **NOTE**: Scheme bắt đầu bằng 'fb' sau đó là mã App Facebook.
    -->
    <string name="fb_login_protocol_scheme">fb000000000000</string>
</resources>
```
Thêm mã sau trong file Android **<your project root>/android/app/src/main/AndroidManifest.xml**

```xml
<meta-data android:name="com.facebook.sdk.ApplicationId"
    android:value="@string/facebook_app_id"/>

<activity android:name="com.facebook.FacebookActivity"
    android:configChanges=
            "keyboard|keyboardHidden|screenLayout|screenSize|orientation"
    android:label="@string/app_name" />

<activity
    android:name="com.facebook.CustomTabActivity"
    android:exported="true">
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="@string/fb_login_protocol_scheme" />
    </intent-filter>
</activity>
```
### Sử dụng trong Flutter
```dart
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

final facebookLogin = FacebookLogin();
final result = await facebookLogin.logIn(['email']);

switch (result.status) {
  case FacebookLoginStatus.loggedIn:
    _sendTokenToServer(result.accessToken.token);
    _showLoggedInUI();
    break;
  case FacebookLoginStatus.cancelledByUser:
    _showCancelledMessage();
    break;
  case FacebookLoginStatus.error:
    _showErrorOnUI(result.errorMessage);
    break;
}
```
Nếu muốn mở dialog trong app thay vì mở ngoài app thì dùng tùy chon sau
```dart
facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
```