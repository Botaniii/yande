import 'package:flutter/material.dart';
import 'package:yande/appliction.dart';
import 'package:yande/route/route.dart';
import 'package:yande/store/store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Application.init();
  await TagStore.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yande',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routes: _buildRoutes(),
    );
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return Map<String, WidgetBuilder>.fromIterable(
      allViewRoutes,
      key: (dynamic demo) => '${demo.routeName}',
      value: (dynamic demo) => demo.buildRoute,
    );
  }
}