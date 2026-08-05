package xyz.xiaopo.yande

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import xyz.xiaopo.yande.plugins.ScanImageFileBroadCastPlugin
import xyz.xiaopo.yande.plugins.StorageAccessPlugin

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        ScanImageFileBroadCastPlugin.registerWith(flutterEngine, applicationContext)
        StorageAccessPlugin.registerWith(flutterEngine, applicationContext)
    }
}