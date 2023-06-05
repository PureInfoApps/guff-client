import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:guff/models/onboarding_process/onboarding_process_model.dart';

// Note: This file is code generated so generate it if missing.
part 'onboarding_nav.g.dart';

/// A command class responsible for navigating back during the onboarding
/// process.
///
/// This command updates the onboarding process by removing the last step, and
/// manages the command state.
@riverpod
class OnboardingNavigateBackCommand extends _$OnboardingNavigateBackCommand {
  @override
  bool build() {
    return false;
  }

  /// Runs the command.
  ///
  /// This method sets the command state to `true` to indicate that it is
  /// running, updates the onboarding process by removing the last step based
  /// on the current state, and then sets the command state to `false` to
  /// indicate that the command has finished.
  ///
  /// The `onboardingProcess` parameter represents the current state of the
  /// onboarding process.
  Future<void> run(OnboardingProcessModel onboardingProcessModel) async {
    // Set command state to true to indicate that the command is running.
    state = true;

    // Update the onboarding process by removing the last step based on the
    // current state.
    if (onboardingProcessModel.joinServerCurrentSteps.isNotEmpty) {
      ref
          .read(onboardingProcessModelStateProvider.notifier)
          .deleteProcessLastStep(false, true);
    } else if (onboardingProcessModel.createServerCurrentSteps.isNotEmpty) {
      ref
          .read(onboardingProcessModelStateProvider.notifier)
          .deleteProcessLastStep(true, false);
    }

    // Set command state to false to indicate that the command is done.
    state = false;
  }
}
