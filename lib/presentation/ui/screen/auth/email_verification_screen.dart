import 'package:commerce/presentation/state_holders/authentication_controller/email_verification_controller.dart';
import 'package:commerce/presentation/ui/screen/auth/complete_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  // Center(
                  //   child: SvgPicture.asset(ImagesUtils.craftyBayLogoSVG,
                  //       width: 100),
                  // ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Welcome ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Please Enter your Email address and Password to Register",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,5}')
                              .hasMatch(value)) {
                        return "please Enter your correct Email";
                      } else {
                        return null;
                      }
                    },
                    controller: _emailTEController,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "  password cannot be empty ";
                      } else {
                        return null;
                      }
                    },
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<EmailVerificationController>(
                        builder: (emailController) {
                      if (emailController.emailVerificationInProgress) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            verifyEmail(emailController);
                          }
                        },
                        child: const Text("NEXT"),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Have an account already? Sign In."))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyEmail(EmailVerificationController controller) async {
    final response = await controller.signUp(
        _emailTEController.text.trim(), _passwordController.text);
    if (response) {
      Get.offAll(() => const CompleteProfileScreen());
    } else {
      // Get.snackbar(
      //     "error", "Email verification has been failed! please try again");
    }
  }
}
