import 'package:flutter/material.dart';

class DownloadView extends StatelessWidget {
  const DownloadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('下载'),
      ),
      body: const Center(
        child: Text('下载列表'),
      ),
    );
  }
}