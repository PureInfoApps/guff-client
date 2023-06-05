import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:guff/models/onboarding_process/onboarding_process_model.dart';

// Note: This file is code generated so generate it if missing.
part 'onboarding_create_server.g.dart';

/// A command class responsible for updating onboarding process to create a
/// server state.
///
/// This command updates the onboarding process to show the server account setup
/// step, and manages the command state.
@riverpod
class OnboardingCreateServerCommand extends _$OnboardingCreateServerCommand {
  @override
  bool build() {
    return false;
  }

  /// Runs the command.
  ///
  /// This method sets the command state to `true` to indicate that it is
  /// running, updates the onboarding process to show the server account setup
  /// step, and then sets the command state to `false` to indicate that the
  /// command has finished.
  Future<void> run() async {
    // Set command state to true to indicate that the command is running.
    state = true;

    // As we choose to create a server, we need to update the onboarding process
    // to show the server account setup step.
    ref
        .read(onboardingProcessModelStateProvider.notifier)
        .updateProcessNextStep(CreateServerStep.createServerAndAccount, null);

    // Set command state to false to indicate that the command is done.
    state = false;
  }
}

/// A command class responsible for spinning up a new server with the account
/// details and updating onboarding process to show the server library paths
/// setup step.
///
/// This command uses the provided `serverAccount` to create a server in the
/// backend, updates the onboarding process to show the server library paths
/// setup step, and manages the command state.
@riverpod
class CreateServerAndAccountCommand extends _$CreateServerAndAccountCommand {
  @override
  bool build() {
    return false;
  }

  /// Runs the command.
  ///
  /// This method sets the command state to `true` to indicate that it is
  /// running, uses the `serverAccount` parameter to create a server in the
  /// backend, updates the onboarding process to show the set library path step,
  /// and then sets the command state to `false` to indicate that the command
  /// has finished.
  ///
  /// The `serverAccount` parameter contains the necessary information for
  /// creating the server.
  Future<void> run(ServerAccountModel serverAccountModel) async {
    // Set command state to true to indicate that the command is running.
    state = true;

    // Use the serverAccount to create a server in the backend through the
    // services
    // ...
    // delay to fake like we're doing something
    await Future<void>.delayed(const Duration(seconds: 1));
    // if the server creation is successful, update the onboarding process
    // otherwise, show an error message snackbar

    // As we completed the server account step, we need to update the onboarding
    // process to show the server library paths setup.
    ref
        .read(onboardingProcessModelStateProvider.notifier)
        .updateProcessNextStep(CreateServerStep.setServerLibraryPaths, null);

    // Set command state to false to indicate that the command is done.
    state = false;
  }
}
