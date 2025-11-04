import 'package:flutter/widgets.dart';
import 'package:wallpaper_studio/utilities/routing/route_paths.dart';

import '../../dashboard.dart';

PageRouteBuilder createRoute({RouteSettings? settings, required Widget child}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

class Routing {
  static PageRoute _getPageRoute({required RouteSettings settings, required Widget viewToShow}) {
    return createRoute(settings: settings, child: viewToShow);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.dashboard:
        return _getPageRoute(settings: settings, viewToShow: const Dashboard());

      default:
        return _getPageRoute(settings: settings, viewToShow: const Dashboard());
    }
  }
}
