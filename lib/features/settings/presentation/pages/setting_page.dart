import 'package:auto_route/auto_route.dart';
import 'package:beu_codelab/core/utils/app_constants.dart';
import 'package:beu_codelab/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:beu_codelab/features/settings/presentation/blocs/app_info/app_info_cubit.dart';
import 'package:beu_codelab/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              final userName =
                  authState is Authenticated ? authState.userName : null;

              return BlocBuilder<AppInfoCubit, AppInfoState>(
                builder: (context, state) {
                  return switch (state) {
                    AppInfoLoaded() => SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 24),
                                    child: CircleAvatar(
                                      radius: 48,
                                      backgroundColor: theme.focusColor,
                                      child: CircleAvatar(
                                        foregroundImage: AssetImage(
                                          Assets.images.appIcon.path,
                                        ),
                                        radius: 40,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppConstants.appName,
                                    style: textTheme.headlineSmall,
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                            const Divider(),

                            // Report a Bug
                            ListTile(
                              leading: Icon(
                                Icons.bug_report,
                                color: theme.primaryColor,
                              ),
                              title: const Text("Report a Bug"),
                              onTap: () {
                                final Uri emailUri = Uri(
                                  scheme: 'mailto',
                                  path: AppConstants.reportBugEmail,
                                  query:
                                      'subject=Bug Report from $userName&body=Please describe the issue here...',
                                );
                                _launchUrl(emailUri);
                              },
                            ),

                            const SizedBox(height: 8),

                            // Logged-in user
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Currently Logged in as:",
                                    style: textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 2),
                                  if (authState
                                      is AuthenticatedWithLeetcodeAccount)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "$userName",
                                          style: textTheme.bodyLarge,
                                        ),
                                        const SizedBox(width: 6),
                                        Icon(
                                          Icons.verified,
                                          color: theme.primaryColor,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  if (authState
                                      is AuthenticatedWithLeetcodeUserName)
                                    Text(
                                      "Guest User: $userName",
                                      style: textTheme.bodyLarge,
                                    ),
                                ],
                              ),
                            ),

                            Center(
                              child: TextButton.icon(
                                onPressed: () {
                                  context.read<AuthBloc>().add(AuthLogout());
                                },
                                label: const Text("Logout"),
                                icon: const Icon(Icons.logout_rounded),
                              ),
                            ),
                          ],
                        ),
                      ),
                    _ => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  };
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
