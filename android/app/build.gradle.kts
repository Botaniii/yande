plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "xyz.xiaopo.yande"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "xyz.xiaopo.yande"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val storePath = System.getenv("YANDE_STORE_FILE")
            if (!storePath.isNullOrEmpty()) {
                storeFile = file(storePath)
                storePassword = System.getenv("YANDE_STORE_PASSWORD") ?: ""
                keyAlias = System.getenv("YANDE_KEY_ALIAS") ?: "yande"
                keyPassword = System.getenv("YANDE_KEY_PASSWORD") ?: ""
            }
        }
    }

    buildTypes {
        release {
            // 环境变量未配置时回退 debug 签名，保证 CI 与日常构建可用；
            // 发布正式版时设置 YANDE_STORE_FILE 等环境变量即可使用独立签名。
            signingConfig = if (System.getenv("YANDE_STORE_FILE").isNullOrEmpty()) {
                signingConfigs.getByName("debug")
            } else {
                signingConfigs.getByName("release")
            }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}