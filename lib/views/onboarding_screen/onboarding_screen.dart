import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guff/commands/onboarding_commands/onboarding_create_server.dart';
import 'package:guff/commands/onboarding_commands/onboarding_join_server.dart';
import 'package:guff/commands/onboarding_commands/onboarding_nav.dart';
import 'package:guff/models/onboarding_process/onboarding_process_model.dart';
import 'package:guff/views/onboarding_screen/create_server.dart';
import 'package:guff/views/onboarding_screen/join_server.dart';
import 'package:guff/views/widgets/onboarding_screen_content_overlay_box.dart';
import 'package:guff/views/widgets/overlay_container.dart';
import 'package:guff/views/widgets/scrolling_movie_covers_background.dart';

/// A widget that represents the onboarding screen.
class OnboardingScreen extends StatelessWidget {
  /// Creates a [OnboardingScreen].
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "GUFF",
          style: TextStyle(),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.7),
      ),
      body: const Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ScrollingMovieCoversBackground(),
          OverlayContainer(),
          OnboardingContent(),
        ],
      ),
    );
  }
}

/// A widget that represents the content above the background and overlay of the
/// onboarding screen.
class OnboardingContent extends ConsumerWidget {
  /// Creates a [OnboardingContent].
  const OnboardingContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current state of the onboarding process.
    OnboardingProcessModel onboardingProcessModel =
        ref.watch(onboardingProcessModelStateProvider);

    // Is true if any of the onboarding commands are currently running.
    bool isProcessing = ref.watch(onboardingNavigateBackCommandProvider) ||
        ref.watch(createServerAndAccountCommandProvider) ||
        ref.watch(onboardingJoinServerCommandProvider) ||
        ref.watch(onboardingCreateServerCommandProvider);

    // Get the current step of the create server process of the onboarding
    // process.
    CreateServerStep? createServerCurrentStep =
        onboardingProcessModel.createServerCurrentSteps.isNotEmpty
            ? onboardingProcessModel.createServerCurrentSteps.last
            : null;

    // Get the current step of the join server process of the onboarding
    // process.
    JoinServerStep? joinServerCurrentStep =
        onboardingProcessModel.joinServerCurrentSteps.isNotEmpty
            ? onboardingProcessModel.joinServerCurrentSteps.last
            : null;

    // Handles the onboarding steps back action.
    Future<void> onBack() async {
      await ref
          .read(onboardingNavigateBackCommandProvider.notifier)
          .run(onboardingProcessModel);
    }

    // Handles the create server and account step next action in the create
    // server process of the onboarding process.
    Future<void> onCreateServerAndAccountNextStep(
      ServerAccountModel serverAccountModel,
    ) async {
      await ref
          .read(createServerAndAccountCommandProvider.notifier)
          .run(serverAccountModel);
    }

    // Handles the make server button action in the onboarding process.
    Future<void> onMakeServer() async {
      await ref.read(onboardingCreateServerCommandProvider.notifier).run();
    }

    // Handles the join server button action in the onboarding process.
    Future<void> onJoinServer() async {
      await ref.read(onboardingJoinServerCommandProvider.notifier).run();
    }

    return WillPopScope(
      onWillPop: () async {
        // Handle device back button action.
        if (createServerCurrentStep != null || joinServerCurrentStep != null) {
          // If the current step is not the first step, go back to the previous
          // onboarding step.
          await onBack();
          // Prevent the default back button behavior.
          return false;
        }
        // Default back button behavior.
        return true;
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        // Explanation for using the RepaintBoundary to fix assertion error when
        // rapidly clicking buttons:
        // When you click a button to trigger a transition between onboarding
        // steps, Flutter starts animating the transition. This rapid clicking
        // can create a situation where multiple animations are running
        // simultaneously, attempting to modify the same widget in an
        // inconsistent state. Flutter's rendering system expects each widget to
        // be a repaint boundary, meaning it can be independently painted and
        // animated. However, when multiple animations are applied to the same
        // widget simultaneously, it violates this assumption. This causes
        // 'node.isRepaintBoundary: is not true' assertion error occurs when
        // trying to animate a widget that is not a repaint boundary.
        // So, by wrapping the onboarding steps with RepaintBoundary, we
        // indicate to Flutter that each step should be treated as a separate
        // layer for painting and animation purposes. This ensures that each
        // animation is applied independently, preventing conflicts between
        // multiple simultaneous animations and resolving the assertion error.

        // Explanation for using keys:
        // AnimatedSwitcher uses keys to identify different child widgets and
        // animate the transitions between them. When the key associated with a
        // child changes, AnimatedSwitcher understands that a different widget
        // is being shown, and it animates the transition accordingly.
        child: RepaintBoundary(
          key: ValueKey<String>(
            '$createServerCurrentStep$joinServerCurrentStep',
          ),
          child: OnboardingScreenStepOverlay(
            child: GetStepContent(
              createServerCurrentStep: createServerCurrentStep,
              joinServerCurrentStep: joinServerCurrentStep,
              isProcessing: isProcessing,
              onBack: onBack,
              onCreateServerAndAccountNextStep:
                  onCreateServerAndAccountNextStep,
              onMakeServer: onMakeServer,
              onJoinServer: onJoinServer,
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget that provides onboarding steps content to [OnboardingContent]
/// widget based on the current step.
class GetStepContent extends StatelessWidget {
  /// Creates a [GetStepContent].
  ///
  /// The [createServerCurrentStep] and [joinServerCurrentStep] parameters are
  /// required. The [onBack], [onCreateServerAndAccountNextStep], [onMakeServer]
  /// , [onJoinServer], and [isProcessing] parameters are optional.
  const GetStepContent({
    Key? key,
    required this.createServerCurrentStep,
    required this.joinServerCurrentStep,
    this.onBack,
    this.onCreateServerAndAccountNextStep,
    this.onMakeServer,
    this.onJoinServer,
    required this.isProcessing,
  }) : super(key: key);

  /// The current step for creating a server.
  final CreateServerStep? createServerCurrentStep;

  /// The current step for joining a server.
  final JoinServerStep? joinServerCurrentStep;

  /// Callback function invoked when the "Back" button is pressed.
  final void Function()? onBack;

  /// Callback function invoked when proceeding to the next step of
  /// creating a server and account step.
  final void Function(ServerAccountModel)? onCreateServerAndAccountNextStep;

  /// Callback function invoked when making a server.
  final void Function()? onMakeServer;

  /// Callback function invoked when joining a server.
  final void Function()? onJoinServer;

  /// Is true if any of the onboarding commands are currently running.
  final bool isProcessing;
  @override
  Widget build(BuildContext context) {
    if (createServerCurrentStep == null && joinServerCurrentStep == null) {
      return WelcomeStepContent(
        onMakeServer: onMakeServer,
        onJoinServer: onJoinServer,
        isProcessing: isProcessing,
      );
    } else if (createServerCurrentStep != null) {
      if (createServerCurrentStep == CreateServerStep.createServerAndAccount) {
        return CreateServerAndAccountStepContent(
          onBack: onBack,
          onNext: onCreateServerAndAccountNextStep,
          isProcessing: isProcessing,
        );
      } else if (createServerCurrentStep ==
          CreateServerStep.setServerLibraryPaths) {
        return SetLibraryPathsStepContent(
          onBack: onBack,
          onNext: () {},
          isProcessing: isProcessing,
        );
      } else {
        return const SizedBox();
      }
    } else if (joinServerCurrentStep == JoinServerStep.joinServer) {
      return JoinServerStepContent(
        onBack: onBack,
        onNext: () {},
        isProcessing: isProcessing,
      );
    } else {
      return const SizedBox();
    }
  }
}

/// A widget that represents the content for the welcome step.
class WelcomeStepContent extends StatelessWidget {
  /// Creates a [WelcomeStepContent].
  ///
  /// The [onMakeServer] and [onJoinServer] parameters are optional.
  const WelcomeStepContent({
    Key? key,
    this.onMakeServer,
    this.onJoinServer,
    required this.isProcessing,
  }) : super(key: key);

  /// Callback function invoked when the "Make Server" button is pressed.
  final void Function()? onMakeServer;

  /// Callback function invoked when the "Join Server" button is pressed.
  final void Function()? onJoinServer;

  /// Is true if processing is in progress.
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    return StepOverlayContent(
      isProcessing: isProcessing,
      titleText: "Welcome to GUFF",
      bodyText: "The slickest media server for your entertainment needs.",
      content: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          FilledButton.tonal(
            onPressed: isProcessing ? null : onMakeServer,
            child: const Text(
              "Make Server",
              textAlign: TextAlign.center,
            ),
          ),
          FilledButton(
            onPressed: isProcessing ? null : onJoinServer,
            child: const Text(
              "Join Server",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
