import 'package:en_notes/UI/splash_screen.dart';
import 'package:en_notes/ui/home/home_screen.dart';
import 'package:en_notes/ui/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String homeScreen = '/homeScreen';
  static const String splashScreen = '/splashScreen';
  static const String settingsScreen = '/settingsScreen';

  static Route<dynamic> generateAppRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return NoAnimationMaterialPageRoute(
            builder: (context) => HomeScreen.provider(context),
            settings: settings
        );
      case splashScreen:
        return NoAnimationMaterialPageRoute(
            builder: (context) => SplashScreen(),
            settings: settings
        );
      case settingsScreen:
        return CupertinoPageRoute(
            builder: (context) => SettingsScreen(),
            settings: settings
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          )
        );
    }
  }
}

class FadeTransitionPageRoute<T> extends MaterialPageRoute<T> {
  FadeTransitionPageRoute({WidgetBuilder builder, RouteSettings settings})
    : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (animation.status == AnimationStatus.reverse)
      return super.buildTransitions(context, animation, secondaryAnimation, child);
    return FadeTransition(opacity: animation, child: child);
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
      builder: builder,
      maintainState: maintainState,
      settings: settings,
      fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}