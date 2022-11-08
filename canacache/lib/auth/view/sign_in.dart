import "dart:async";
import "package:flutter/material.dart";
import "package:canacache/auth/model/auth.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_signin_button/flutter_signin_button.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:canacache/common_widgets/cana_snackbar.dart";
import "package:canacache/common_widgets/cana_scaffold.dart";
import "package:provider/provider.dart";
import "package:canacache/theming/models/cana_palette_model.dart";
import "package:canacache/settings/model/settings_provider.dart";

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  //part of the code from the navigation is taken from https://stackoverflow.com/questions/54101589/navigating-to-a-new-screen-when-stream-value-in-bloc-changes
  StreamSubscription? _streamSubscription;

  @override
  initState() {
    super.initState();
    _listen();
  }

  @override
  dispose() {
    _streamSubscription!.cancel();
    super.dispose();
  }

  _listen() {
    _streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          successCanaSnackBar(
            context,
            "Successfully signed in as ${user.email}",
          ),
        );
        Navigator.pushNamedAndRemoveUntil(context, "homePage", (val) => false);
      }
    });
  }

  Widget signInPage(BuildContext context) {
    return CanaScaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset("assets/vectors/logo.svg"),
              Padding(
                padding: const EdgeInsets.all(30),
                child: SizedBox(
                  width: 200,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Provider.of<SettingsProvider>(context)
                          .getTheme()
                          .primaryTextColor,
                    ),
                  ),
                ),
              ),
              SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () {
                  challengeSnackBarAsync(
                    context,
                    () => UserAuth.signInWithGoogle(context: context),
                  );
                },
              ),
              SignInButton(
                Buttons.GitHub,
                text: "Sign in with GitHub",
                onPressed: () {
                  challengeSnackBarAsync(
                    context,
                    () => UserAuth.signInWithGithub(context: context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return signInPage(context);
  }
}
