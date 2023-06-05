import 'package:flutter/material.dart';
import 'package:guff/views/widgets/onboarding_screen_content_overlay_box.dart';

/// A widget that represents the content for joining a server.
class JoinServerStepContent extends StatelessWidget {
  /// Creates a [JoinServerStepContent].
  ///
  /// The [onBack] and [onNext] parameters are optional callbacks for back and
  /// next actions.
  const JoinServerStepContent({
    Key? key,
    this.onBack,
    this.onNext,
    required this.isProcessing,
  }) : super(key: key);

  /// Callback function invoked when the "Back" button is pressed.
  final void Function()? onBack;

  /// Callback function invoked when the "Next" button is pressed.
  final void Function()? onNext;

  /// Is true if processing is in progress.
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    // The theme of the app in the current context.
    final ThemeData theme = Theme.of(context);

    return IntrinsicWidth(
      child: StepOverlayContent(
        isProcessing: isProcessing,
        titleText: "Join Server",
        bodyText:
            "Join a server to access your entertainment choices from anywhere",
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Address",
                hintText: "localhost",
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                labelText: "Port",
                hintText: "8037",
              ),
            ),
            const SizedBox(height: 16),
            // For large text use a fixed size as the text would be the largest
            // widget in the widget leading to increase in intrinsic width
            // causing it to as much space until overflow occurs after which
            // only it would wrap.
            Text(
              "Note:",
              style: theme.textTheme.labelMedium,
              softWrap: true,
              textAlign: TextAlign.start,
            ),
            Text(
              "1. By default 8037 port is used.",
              style: theme.textTheme.labelSmall,
              softWrap: true,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            Center(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  OutlinedButton(
                    onPressed: onBack,
                    child: const Text(
                      "Back",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FilledButton(
                    onPressed: onNext,
                    child: const Text(
                      "Next",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
