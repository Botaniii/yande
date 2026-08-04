import 'package:flutter/material.dart';
import 'package:yande/appliction.dart';
import 'package:yande/route/route.dart';
import 'package:yande/store/store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Application.init();
    await TagStore.init();
  } catch (e, st) {
    // 初始化失败时不要黑屏：打日志并显示错误页，便于定位问题。
    debugPrint('FATAL init error: $e\n$st');
    runApp(InitErrorApp(error: e.toString()));
    return;
  }
  runApp(const MyApp());
}

class InitErrorApp extends StatelessWidget {
  final String error;

  const InitErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SelectableText(
              '初始化失败：\n$error\n\n请截图并反馈此信息。',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
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