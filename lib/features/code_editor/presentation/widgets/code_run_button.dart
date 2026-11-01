import 'dart:ui';

import 'package:beu_codelab/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:beu_codelab/features/code_editor/presentation/blocs/code_editor/code_editor_bloc.dart';
import 'package:beu_codelab/features/code_editor/presentation/widgets/leetcode_login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodeRunButton extends StatelessWidget {
  const CodeRunButton({
    super.key,
    required this.runCode,
  });

  final Null Function() runCode;

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final allowCodeRun = authBloc.isUserAuthenticatedWithLeetcodeAccount;
    return BlocBuilder<CodeEditorBloc, CodeEditorState>(
      builder: (context, state) {
        final isRunning = state.executionState == CodeExecutionPending();

        return Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              visible: (isRunning),
              child: const CircularProgressIndicator(),
            ),
            Visibility(
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              visible: !isRunning,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (allowCodeRun)
                    ElevatedButton.icon(
                      onPressed: runCode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).focusColor,
                        foregroundColor: Theme.of(context).primaryColor,
                        iconColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Run Code'),
                    )
                  else
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(8.0), // Match button shape
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: 10.0, sigmaY: 10.0), // Blur intensity
                        child: OutlinedButton.icon(
                          onPressed: () => LeetcodeLoginDialog.show(context),
                          icon: const Icon(
                            Icons.lock,
                          ), // Change to lock icon for clarity
                          label: const Text('Locked'),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
