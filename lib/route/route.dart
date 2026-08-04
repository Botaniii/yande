import 'package:flutter/material.dart';
import 'package:yande/view/collectView/collectImageView.dart';
import 'package:yande/view/index/indexView.dart';
import 'package:yande/view/search/searchView.dart';
import 'package:yande/view/setting/settingView.dart';

class ViewRoute {
  const ViewRoute({
    required this.title,
    this.icon,
    this.subtitle,
    required this.routeName,
    required this.buildRoute,
  });

  final String title;
  final IconData? icon;
  final String? subtitle;
  final String routeName;
  final WidgetBuilder buildRoute;

  @override
  String toString() {
    return '$runtimeType($title $routeName)';
  }
}

List<ViewRoute> _allViewRoutes() {
  return <ViewRoute>[
    ViewRoute(
      title: IndexView.title,
      routeName: IndexView.route,
      buildRoute: (BuildContext context) => const IndexView(),
    ),
    ViewRoute(
      title: CollectImageView.title,
      routeName: CollectImageView.route,
      buildRoute: (BuildContext context) => const CollectImageView(),
    ),
    ViewRoute(
      title: SettingView.title,
      routeName: SettingView.route,
      buildRoute: (BuildContext context) => const SettingView(),
    ),
    ViewRoute(
      title: TagSearchView.title,
      routeName: TagSearchView.route,
      buildRoute: (BuildContext context) => const TagSearchView(),
    ),
  ];
}

final List<ViewRoute> allViewRoutes = _allViewRoutes();