import 'package:flutter/material.dart';
import 'package:guff/views/widgets/onboarding_screen_content_overlay_box.dart';
import 'package:guff/models/onboarding_process/onboarding_process_model.dart';

/// A widget that represents the content for securing the server step.
class CreateServerAndAccountStepContent extends StatelessWidget {
  /// Creates a [CreateServerAndAccountStepContent].
  ///
  /// The [onBack] and [onNext] parameters are optional callbacks for back and
  /// next actions.
  const CreateServerAndAccountStepContent({
    Key? key,
    this.onBack,
    this.onNext,
    required this.isProcessing,
  }) : super(key: key);

  /// Callback function invoked when the "Back" button is pressed.
  final void Function()? onBack;

  /// Callback function invoked when the "Next" button is pressed.
  final void Function(ServerAccountModel serverAccountModel)? onNext;

  /// Is true if processing is in progress.
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    // The theme of the app in the current context.
    final ThemeData theme = Theme.of(context);

    return IntrinsicWidth(
      child: StepOverlayContent(
        isProcessing: isProcessing,
        titleText: "Secure Server",
        bodyText:
            "Protect your entertainment choices from unwanted prying eyes",
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Username",
                hintText: "johndoe",
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                labelText: "Password",
                hintText: "•••••••••••",
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                labelText: "Confirm Password",
                hintText: "•••••••••••",
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
              "1. The above credentials allow full server control.",
              style: theme.textTheme.labelSmall,
              softWrap: true,
              textAlign: TextAlign.start,
            ),
            Text(
              "2. Profiles with limited access can be created later "
              "in the settings.",
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
                    onPressed: isProcessing ? null : onBack,
                    child: const Text(
                      "Back",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FilledButton(
                    onPressed: isProcessing || onNext == null
                        ? null
                        : () {
                            onNext!(
                              const ServerAccountModel(
                                username: "johndoe",
                                password: "test",
                              ),
                            );
                          },
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

/// A widget that represents the content for setting the server library step.
class SetLibraryPathsStepContent extends StatelessWidget {
  /// Creates a [SetLibraryPathsStepContent].
  ///
  /// The [onBack] and [onNext] parameters are optional callbacks for back and
  /// next actions.
  const SetLibraryPathsStepContent({
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

    // TODO(chaudharydeepanshu): Use create server model for library paths
    final List<ServerLibraryModel> serverLibraryModels = <ServerLibraryModel>[
      const ServerLibraryModel(
        name: "Movies",
        path: "C:/Movies",
      ),
      const ServerLibraryModel(
        name: "TV Shows",
        path: "C:/TV Shows",
      ),
      const ServerLibraryModel(
        name: "Anime",
        path: "C:/Anime",
      ),
    ];

    Future<void> onRemove(int libraryIndex) async {
      // TODO(chaudharydeepanshu): Implement remove library path
      // Call command for removing library path from the create server model
    }

    Future<void> onAdd() async {
      // On add is called once the dialog for selection of library path is
      // closed
      // TODO(chaudharydeepanshu): Implement add library path.
      // Call command for add library path to the create server model
    }

    return IntrinsicWidth(
      child: StepOverlayContent(
        isProcessing: isProcessing,
        titleText: "Library Paths",
        bodyText: "Add the path of your amazing collection of movies and shows",
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(
                serverLibraryModels.length,
                (int index) => LibraryPathListTile(
                  name: serverLibraryModels[index].name,
                  path: serverLibraryModels[index].path,
                  onRemove: () {
                    onRemove(index);
                  },
                ),
              ) +
              <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.tonalIcon(
                    onPressed: isProcessing ? null : onNext,
                    icon: const Icon(Icons.add),
                    label: const Text(
                      "Add Path",
                      textAlign: TextAlign.center,
                    ),
                  ),
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
                        onPressed: isProcessing ? null : onBack,
                        child: const Text(
                          "Back",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FilledButton(
                        onPressed: isProcessing ? null : onNext,
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

/// A widget that represents a list tile for a library path.
class LibraryPathListTile extends StatelessWidget {
  /// Creates a [LibraryPathListTile].
  ///
  /// The [name] and [path] parameters must not be null and [onRemove] is
  /// optional.
  const LibraryPathListTile({
    super.key,
    required this.name,
    required this.path,
    this.onRemove,
  });

  /// The name of the library path.
  final String name;

  /// The path of the library.
  final String path;

  /// Callback function invoked when the remove library button is pressed.
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    // The theme of the app in the current context.
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: () {},
        leading: Icon(
          Icons.folder,
          color: theme.colorScheme.outline,
        ),
        title: Text(
          name,
          style: TextStyle(color: theme.colorScheme.outline),
        ),
        subtitle: Text(
          path,
          style: TextStyle(color: theme.colorScheme.outline),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.remove),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
