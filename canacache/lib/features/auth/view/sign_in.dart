import "package:canacache/common/utils/cana_palette_model.dart";
import "package:canacache/common/utils/mvc.dart";
import "package:canacache/common/utils/routes.dart";
import "package:canacache/common/utils/snackbars.dart";
import "package:canacache/common/widgets/scaffold.dart";
import "package:canacache/features/auth/controller/sign_in_controller.dart";
import "package:canacache/features/settings/model/settings_provider.dart";
import "package:flutter/material.dart";
import "package:flutter_signin_button/flutter_signin_button.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:provider/provider.dart";

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State createState() => SignInFormState();
}

class SignInFormState extends ViewState<SignInForm, SignInFormController> {
  SignInFormState() : super(SignInFormController());

  void onSuccessfulSignIn(String email) {
    ScaffoldMessenger.of(context).showSnackBar(
      successCanaSnackBar(context, "Successfully signed in as $email"),
    );

    Navigator.pushReplacementNamed(context, CanaRoute.home.name);
  }

  @override
  Widget build(BuildContext context) {
    CanaTheme theme = Provider.of<SettingsProvider>(context).theme;

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
                      color: theme.primaryTextColor,
                    ),
                  ),
                ),
              ),
              SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: con.signInWithGoogle,
              ),
              SignInButton(
                Buttons.GitHub,
                text: "Sign in with GitHub",
                onPressed: con.signInWithGitHub,
              ),
            ],
          ),
        ),
      ),
    );
  }
}