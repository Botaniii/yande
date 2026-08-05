package com.botaniii.yande

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.botaniii.yande.plugins.ScanImageFileBroadCastPlugin
import com.botaniii.yande.plugins.StorageAccessPlugin
import com.botaniii.yande.plugins.ApkInstallPlugin

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        ScanImageFileBroadCastPlugin.registerWith(flutterEngine, applicationContext)
        StorageAccessPlugin.registerWith(flutterEngine, applicationContext)
        ApkInstallPlugin.registerWith(flutterEngine, applicationContext)
    }
}