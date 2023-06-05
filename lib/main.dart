import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guff/views/onboarding_screen/onboarding_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// The root widget of the app.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'Guff Client',
          theme: ThemeData(
            colorScheme: lightDynamic ?? const ColorScheme.light(),
            useMaterial3: true,
            fontFamily: 'LexendDeca',
          ),
          darkTheme: ThemeData(
            colorScheme: darkDynamic ?? const ColorScheme.dark(),
            useMaterial3: true,
            fontFamily: 'LexendDeca',
          ),
          home: const OnboardingScreen(),
        );
      },
    );
  }
}
