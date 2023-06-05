import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Note: These files are code generated so generate them if they are missing.
part 'onboarding_process_model.freezed.dart';
part 'onboarding_process_model.g.dart';

/// An enum representing the steps involved in creating a server.
enum CreateServerStep {
  /// The step for creating a server and account.
  createServerAndAccount,

  /// The step for setting server library paths.
  setServerLibraryPaths,
}

/// An enum representing the steps involved in joining a server.
enum JoinServerStep {
  /// The step for joining a server.
  joinServer,

  /// The step for logging in to the joined server.
  loginServer,
}

/// A class representing the onboarding process model.
///
/// This class encapsulates the current steps involved in creating a server and
/// joining a server in the onboarding process.
@freezed
class OnboardingProcessModel with _$OnboardingProcessModel {
  /// Default constructor for the [OnboardingProcessModel].
  const factory OnboardingProcessModel({
    /// The list of current steps involved in creating a server.
    @Default(<CreateServerStep>[])
    List<CreateServerStep> createServerCurrentSteps,

    /// The list of current steps involved in joining a server.
    @Default(<JoinServerStep>[]) List<JoinServerStep> joinServerCurrentSteps,
  }) = _OnboardingProcessModel;

  /// Creates an [OnboardingProcessModel] instance from a JSON [Map].
  factory OnboardingProcessModel.fromJson(Map<String, Object?> json) =>
      _$OnboardingProcessModelFromJson(json);
}

/// A class representing the state of the onboarding process model.
///
/// This class is used to manage the state of the onboarding process model.
@riverpod
class OnboardingProcessModelState extends _$OnboardingProcessModelState {
  @override
  OnboardingProcessModel build() {
    return const OnboardingProcessModel();
  }

  /// Updates the onboarding process by adding a new step.
  ///
  /// The [newCreateServerStep] parameter represents the new step to be added to
  /// the create server process, while the [newJoinServerStep] parameter
  /// represents the new step to be added to the join server process. Only one
  /// of these parameters should be non-null.
  void updateProcessNextStep(
    CreateServerStep? newCreateServerStep,
    JoinServerStep? newJoinServerStep,
  ) {
    state = newCreateServerStep != null
        ? state.copyWith(
            createServerCurrentSteps: <CreateServerStep>[
              ...state.createServerCurrentSteps,
              newCreateServerStep,
            ],
          )
        : state.copyWith(
            joinServerCurrentSteps: <JoinServerStep>[
              ...state.joinServerCurrentSteps,
              newJoinServerStep!,
            ],
          );
  }

  /// Deletes the last step from the current process in the onboarding process.
  ///
  /// If [deleteCreateServerLastStep] is `true`, it removes the last step from
  /// the [createServerCurrentSteps] list of the state.
  /// If [deleteJoinServerLastStep] is `true`, it removes the last step from
  /// the [joinServerCurrentSteps] list of the state.
  void deleteProcessLastStep(
    bool deleteCreateServerLastStep,
    bool deleteJoinServerLastStep,
  ) {
    state = deleteCreateServerLastStep
        ? state.copyWith(
            createServerCurrentSteps: state.createServerCurrentSteps
                .sublist(0, state.createServerCurrentSteps.length - 1),
          )
        : state.copyWith(
            joinServerCurrentSteps: state.joinServerCurrentSteps
                .sublist(0, state.joinServerCurrentSteps.length - 1),
          );
  }
}

/// A class representing the server account model.
///
/// This class contains information about a server account, including the
/// username and password.
@freezed
class ServerAccountModel with _$ServerAccountModel {
  /// Default constructor for the [ServerAccountModel].
  const factory ServerAccountModel({
    /// The username of the server account.
    required String username,

    /// The password of the server account.
    required String password,
  }) = _ServerAccountModel;

  /// Creates a [ServerAccountModel] instance from a JSON [Map].
  factory ServerAccountModel.fromJson(Map<String, Object?> json) =>
      _$ServerAccountModelFromJson(json);
}

/// A class representing the server library model.
///
/// This class contains information about a server library, including the name
/// and path.
@freezed
class ServerLibraryModel with _$ServerLibraryModel {
  /// Default constructor for the [ServerLibraryModel].
  const factory ServerLibraryModel({
    /// The name of the server library.
    required String name,

    /// The path of the server library.
    required String path,
  }) = _ServerLibraryModel;

  /// Creates a [ServerLibraryModel] instance from a JSON [Map].
  factory ServerLibraryModel.fromJson(Map<String, Object?> json) =>
      _$ServerLibraryModelFromJson(json);
}
