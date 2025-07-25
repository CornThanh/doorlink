import 'dart:async';

import 'package:doorlink_mobile/features/main/message/presentation/chat_screen_widget.dart';
import 'package:doorlink_mobile/features/main/notification/presentation/notification_screen_widget.dart';
import 'package:doorlink_mobile/features/main/vcard/presentation/update_vcard_screen_widget.dart';
import 'package:doorlink_mobile/webview/presentation/webview_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/auth/custom_auth/custom_auth_user_provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  InfyVcardAuthUser? initialUser;
  InfyVcardAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(InfyVcardAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => appStateNotifier.loggedIn
          ? const TabBarScreenWidget()
          : const LoginScreenWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? const TabBarScreenWidget()
              : const LoginScreenWidget(),
        ),
        FFRoute(
          name: 'tabbar_screen',
          path: '/tabbarScreen',
          builder: (context, params) => const TabBarScreenWidget(),
        ),
        FFRoute(
          name: 'language_screen',
          path: '/languageScreen',
          builder: (context, params) => LanguageScreenWidget(
            isChange: params.getParam('isChange', ParamType.bool),
          ),
        ),
        FFRoute(
          name: 'login_screen',
          path: '/loginScreen',
          builder: (context, params) => const LoginScreenWidget(),
        ),
        FFRoute(
          name: 'forgot_password_screen',
          path: '/forgotPasswordScreen',
          builder: (context, params) => const ForgotPasswordScreenWidget(),
        ),
        FFRoute(
          name: 'reset_password_screen',
          path: '/resetPasswordScreen',
          builder: (context, params) => ResetPasswordScreenWidget(
            token: params.getParam('token', ParamType.String),
            email: params.getParam('email', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'dashboard',
          path: '/dashboard',
          builder: (context, params) => const DashboardScreenWidget(),
        ),
        FFRoute(
          name: 'vcard_screen',
          path: '/vcardScreen',
          builder: (context, params) => VcardScreenWidget(
            isCreate: params.getParam('isCreate', ParamType.bool) ?? false,
          ),
        ),
        FFRoute(
          name: 'appointment_screen',
          path: '/appointmentScreen',
          builder: (context, params) => AppointmentScreenWidget(
            vcardID: params.getParam('vcardID', ParamType.int),
          ),
        ),
        FFRoute(
          name: 'enquiries_screen',
          path: '/enquiriesScreen',
          builder: (context, params) => EnquiriesScreen(
            vcardID: params.getParam('vcardID', ParamType.int),
          ),
        ),
        FFRoute(
          name: 'setting_screen',
          path: '/settingScreen',
          builder: (context, params) => const SettingScreenWidget(),
        ),
        FFRoute(
          name: 'change_password_screen',
          path: '/changePasswordScreen',
          builder: (context, params) => const ChangePasswordScreenWidget(),
        ),
        FFRoute(
          name: 'edit_profile_screen',
          path: '/editProfileScreen',
          builder: (context, params) => EditProfileScreenWidget(
            profileData: params.getParam('profileData', ParamType.JSON),
          ),
        ),
        FFRoute(
          name: 'business_card_screen',
          path: '/businessCardScreen',
          builder: (context, params) => const BusinessCardScreen(),
        ),
        FFRoute(
          name: 'phone_number',
          path: '/phoneNumber',
          builder: (context, params) => const PhoneNumberScreenWidget(),
        ),
        FFRoute(
          name: 'otp',
          path: '/otp',
          builder: (context, params) => OtpScreenWidget(
            phoneNumber: params.getParam('phoneNumber', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'register_screen',
          path: '/registerScreen',
          builder: (context, params) => const RegisterScreenWidget(),
        ),
        FFRoute(
          name: 'update_vcard_screen',
          path: '/updateVcardScreen',
          builder: (context, params) {
            return UpdateVcardScreenWidget(
              vcardID: params.getParam('vcardID', ParamType.int),
            );
          },
        ),
        FFRoute(
          name: 'notification_screen',
          path: '/notificationScreen',
          builder: (context, params) => const NotificationScreenWidget(),
        ),
        FFRoute(
          name: 'chat_screen',
          path: '/chatScreen',
          builder: (context, params) => ChatScreenWidget(),
        ),
        FFRoute(
          name: 'webview_screen',
          path: '/webviewScreen',
          builder: (context, params) => WebviewScreenWidget(
            title: params.getParam('title', ParamType.String),
          ),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/loginScreen';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: const Color(0xffffffff),
                  child: Center(
                    child: Image.asset(
                      'assets/images/splash_image.png',
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      height: MediaQuery.sizeOf(context).height * 0.2,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(
        hasTransition: true,
        transitionType: PageTransitionType.fade,
        duration: Duration(milliseconds: 300),
      );
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouter.of(context).location;
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}
