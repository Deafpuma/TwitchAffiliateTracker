# Flutter Default ProGuard Rules
-keep class io.flutter.** { *; }
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class androidx.** { *; }
-keep class com.google.ads.** { *; }
-dontwarn com.google.**
-dontwarn androidx.**
-dontwarn io.flutter.**

# Prevent Firebase Crashlytics from obfuscating logs
-keepattributes SourceFile,LineNumberTable
-keep public class ** extends java.lang.Exception { *; }

