import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;
import 'package:oauth_webauth/oauth_webauth.dart';

class OAuthWebView extends BaseWebView {

  /// A URL provided by the authorization server that serves as the base for the
  /// URL that the resource owner will be redirected to to authorize this
  /// client.
  ///
  /// This will usually be listed in the authorization server's OAuth2 API
  /// documentation.
  final String authorizationEndpointUrl;

  /// A URL provided by the authorization server that this library uses to
  /// obtain long-lasting credentials.
  ///
  /// This will usually be listed in the authorization server's OAuth2 API
  /// documentation.
  final String tokenEndpointUrl;

  /// The redirectUrl to which the authorization server will redirect to when
  /// authorization flow completes.
  final String redirectUrl;

  /// It is another redirectUrl to be used by the authorization server when the
  /// user decides to go back to application instead of completing
  /// authorization flow.
  final String? baseUrl;

  /// The client identifier for this client.
  ///
  /// The authorization server will issue each client a separate client
  /// identifier and secret, which allows the server to tell which client is
  /// accessing it. Some servers may also have an anonymous identifier/secret
  /// pair that any client may use.
  ///
  /// This is usually global to the program using this library.
  final String clientId;

  /// The client secret for this client.
  ///
  /// The authorization server will issue each client a separate client
  /// identifier and secret, which allows the server to tell which client is
  /// accessing it. Some servers may also have an anonymous identifier/secret
  /// pair that any client may use.
  ///
  /// This is usually global to the program using this library.
  ///
  /// Note that clients whose source code or binary executable is readily
  /// available may not be able to make sure the client secret is kept a secret.
  /// This is fine; OAuth2 servers generally won't rely on knowing with
  /// certainty that a client is who it claims to be.
  final String? clientSecret;

  /// A [String] used to separate scopes; defaults to `" "`.
  final String? delimiter;

  /// Whether to use HTTP Basic authentication for authorizing the client.
  final bool? basicAuth;

  /// The HTTP client used to make HTTP requests.
  final http.Client? httpClient;

  /// The scopes that the client is requesting access to.
  final List<String>? scopes;

  /// /// Hint to the Authorization Server about the login identifier the End-User might use to log in.
  final String? loginHint;

  /// List of ASCII string values that specifies whether the Authorization Server prompts the End-User for re-authentication and consent.
  /// e.g: promptValues: ['login'].
  /// In this case it prompts the user login even if they have already signed in.
  /// The list of supported values depends on the identity provider.
  final List<String>? promptValues;

  /// This function will be called when user successfully authenticates.
  /// It will receive the Oauth Credentials
  final ValueChanged<oauth2.Credentials> onSuccessAuth;

  OAuthWebView({
    Key? key,
    required this.authorizationEndpointUrl,
    required this.tokenEndpointUrl,
    required this.redirectUrl,
    this.baseUrl,
    required this.clientId,
    this.clientSecret,
    this.delimiter,
    this.basicAuth,
    this.httpClient,
    this.scopes,
    this.loginHint,
    this.promptValues,
    required this.onSuccessAuth,
    required ValueChanged<dynamic> onError,
    required VoidCallback onCancel,
    CertificateValidator? onCertificateValidate,
    ThemeData? themeData,
    Map<String, String>? textLocales,
    Locale? contentLocale,
    Map<String, String>? headers,
    Stream<String>? urlStream,
    bool? goBackBtnVisible,
    bool? goForwardBtnVisible,
    bool? refreshBtnVisible,
    bool? clearCacheBtnVisible,
    bool? closeBtnVisible,
  }) : super(
          key: key,

          /// Initial url is generated by initOauth(...) function call below.
          initialUrl: '',

          /// Redirect urls is generated by initOauth(...) function call below.
          redirectUrls: [],
          onError: onError,
          onCancel: onCancel,
          onCertificateValidate: onCertificateValidate,
          themeData: themeData,
          textLocales: textLocales,
          contentLocale: contentLocale,
          headers: headers,
          urlStream: urlStream,
          goBackBtnVisible: goBackBtnVisible,
          goForwardBtnVisible: goForwardBtnVisible,
          refreshBtnVisible: refreshBtnVisible,
          clearCacheBtnVisible: clearCacheBtnVisible,
          closeBtnVisible: closeBtnVisible,
        );

  @override
  OAuthWebViewState createState() => OAuthWebViewState();
}

class OAuthWebViewState extends BaseWebViewState<OAuthWebView>
    with WidgetsBindingObserver, BaseOAuthFlowMixin {
  @override
  void initBase() {
    super.initBase();
    initOauth(
      authorizationEndpointUrl: widget.authorizationEndpointUrl,
      tokenEndpointUrl: widget.tokenEndpointUrl,
      redirectUrl: widget.redirectUrl,
      baseUrl: widget.baseUrl,
      clientId: widget.clientId,
      clientSecret: widget.clientSecret,
      delimiter: widget.delimiter,
      basicAuth: widget.basicAuth,
      httpClient: widget.httpClient,
      scopes: widget.scopes,
      loginHint: widget.loginHint,
      promptValues: widget.promptValues,
      onSuccessAuth: widget.onSuccessAuth,
      onError: widget.onError,
      onCancel: widget.onCancel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? const SizedBox() : super.build(context);
  }
}
