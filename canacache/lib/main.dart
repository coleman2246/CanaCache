import "dart:async";
import "package:canacache/features/app/view/app.dart";
import "package:canacache/features/settings/model/i18n_preferences.dart";
import "package:canacache/features/stats_recording/distance_recorder.dart";
import "package:canacache/features/stats_recording/step_recorder.dart";
import "package:canacache/features/stats_recording/time_recorder.dart";
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

  TimeRecorder timeRecorder = TimeRecorder();
  DistanceRecorder distRecorder = DistanceRecorder();

  Timer.periodic(
    const Duration(seconds: TimeRecorder.interval),
    (Timer t) => timeRecorder.newEpoch(),
  );

  Timer.periodic(
    const Duration(seconds: DistanceRecorder.interval),
    (Timer t) => distRecorder.newEpoch(),
  );

  StepRecorder stepRecorder = StepRecorder();

  Timer.periodic(
    const Duration(seconds: StepRecorder.interval),
    (Timer t) => stepRecorder.newEpoch(),
  );

  // add flutter_translate delegate
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: "en",
    supportedLocales: ["en", "pt_BR"],
    preferences: TranslatePreferences(),
  );

  runApp(LocalizedApp(delegate, const CanaApp()));
}
