import "package:canacache/features/app/view/app.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_translate/flutter_translate.dart";

void main() async {
  // lock to portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // add flutter_translate delegate
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: "en",
    supportedLocales: ["en", "pt_BR"],
  );

  runApp(LocalizedApp(delegate, const CanaApp()));
}
