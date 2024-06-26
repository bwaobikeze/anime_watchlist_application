//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

// import 'package:oauth2_client/oauth2_client.dart';
// import 'package:oauth2_client/oauth2_helper.dart';
// import 'package:oauth2_client/oauth2_response.dart';


class AnlistAuth {
  static const String clientId = '17299';
  static const String ClientSecret = 'fWbOJjTS53Jua2orSZD3TZr0eDtHU3TN0AalRu5A';
  static const String authorizationUrl =
      'https://anilist.co/api/v2/oauth/authorize';
  static const String redirectUrl = 'animewatchlistapp://oauth';
  static final String tokenUrl = 'https://anilist.co/api/v2/oauth/token';

  static oauth2.AuthorizationCodeGrant _grant = oauth2.AuthorizationCodeGrant(
      clientId, Uri.parse(authorizationUrl), Uri.parse(tokenUrl),
      secret: ClientSecret, basicAuth: false);

  static oauth2.Client? _client;
  static String? _authorizationUrl;

  static Future<bool> authorize() async {
    // if (_client != null) {
    //   // Client already authorized, no need to authorize again
    //   return true;
    // }

    // Need to authorize the client
    var authorizationUrl =
        _grant.getAuthorizationUrl(Uri.parse(redirectUrl)).toString();
    print('Authorization URL generated: $authorizationUrl');

    // Launch the authorization URL in a webview or external browser
    await launchUrl(Uri.parse(authorizationUrl));

    // After the user authorizes the app, they will be redirected to the redirect URL with the authorization code
    // Parse the authorization code from the URL
    Uri? redirectUri = await getRedirectUri();

    String? authorizationCode = redirectUri?.queryParameters['code'];

    // Exchange the authorization code for an access token
    if (authorizationCode != null) {
      oauth2.Client client =
          await _grant.handleAuthorizationResponse({'code': authorizationCode});

      // Save the client for future requests
      _client = client;
      //print(_client!.credentials.accessToken);



      return true;
    } else {
      return false;
    }
  }

  static Future<Uri?> getRedirectUri() async {
    // Request permission to access the device's URL
    await getInitialLink();
    // Listen to incoming links
    return uriLinkStream.first;
  }

  static Future<String> getAccessToken() async {
    if (_client == null) {
      throw Exception('Client not initialized. Call authorize() first.');
    }
    return _client!.credentials.accessToken;
  }

  static Future<void> refreshToken() async {
    if (_client == null) {
      throw Exception('Client not initialized. Call authorize() first.');
    }
    _client = await _client!.refreshCredentials();
  }

  static Future<void> logout() async {
    await launchUrl(Uri.parse("https://anilist.co/settings/apps"));
    _grant.close();
    //client.dispose();
    _client = null;
    //_authorizationUrl = null;
  }
}

