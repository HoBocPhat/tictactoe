import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'configs/flavor_config.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlavorConfig(
      flavor: Flavor.dev, values: FlavorValues(baseUrl: 'https://abc.com/api'));
  runApp(const App());
}
