import 'package:commerce/presentation/state_holders/authentication_controller/email_verification_controller.dart';
import 'package:commerce/presentation/ui/screen/auth/complete_profile_screen.dart';
import 'package:commerce/presentation/ui/screen/auth/email_verification_screen.dart';
import 'package:commerce/presentation/ui/screen/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                    "Welcome Back",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Please Enter your Email address",
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
                            login(emailController);
                          }
                        },
                        child: const Text("LOGIN"),
                      );
                    }),
                  ),
                 
                  const SizedBox(
                    height: 20,
                  ),

                  GestureDetector(
                      onTap: () {
                        Get.to(const EmailVerificationScreen());
                      },
                      child: const Text("Dont have an account? Register."))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login(EmailVerificationController controller) async {
    final response = await controller.login(
        _emailTEController.text.trim(), _passwordController.text);
    if (response) {
      Get.offAll(() => const BottomNavBarScreen());
    } else {
      // Get.snackbar(
      //     "error", "Email verification has been failed! please try again");
    }
  }
}
