import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:guff/models/onboarding_process/onboarding_process_model.dart';

// Note: This file is code generated so generate it if missing.
part 'onboarding_join_server.g.dart';

/// A command class responsible for updating onboarding process to join a server
/// state.
///
/// This command updates the onboarding process to show the server join step,
/// and manages the command state.
@riverpod
class OnboardingJoinServerCommand extends _$OnboardingJoinServerCommand {
  @override
  bool build() {
    return false;
  }

  /// Runs the command.
  ///
  /// This method sets the command state to `true` to indicate that it is
  /// running, updates the onboarding process to show the server join step, and
  /// then sets the command state to `false` to indicate that the command has
  /// finished.
  Future<void> run() async {
    // Set command state to true to indicate that the command is running.
    state = true;

    // As we choose to join a server, we need to update the onboarding process
    // to show the join step.
    ref
        .read(onboardingProcessModelStateProvider.notifier)
        .updateProcessNextStep(null, JoinServerStep.joinServer);

    // Set command state to false to indicate that the command is done.
    state = false;
  }
}
