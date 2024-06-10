import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_and_note/services/auth_http_services.dart';
import 'package:todo_and_note/view/screens/auth/login_screen.dart';
import 'package:todo_and_note/view/screens/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  String? email, password, passwordConfirm;
  bool isLoading = false;

  bool hidePasswordFiled = true;
  bool hideConfirmPasswordField = true;

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // register
      setState(() {
        isLoading = true;
      });

      try {
        await _authHttpServices.register(email!, password!);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => const MainScreen()),
        );
      } catch (e) {
        String message = e.toString();

        if (e.toString().contains("EMAIL_EXISTS")) {
          message = "Email is exists";
        }

        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const FlutterLogo(
                  size: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter your email";
                    } else if (!value.contains('@') || !value.contains('.')) {
                      return "Email is not correct";
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    // save email
                    email = newValue;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: hidePasswordFiled,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePasswordFiled = !hidePasswordFiled;
                        });
                      },
                      icon: hidePasswordFiled
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please, enter your password";
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    // save password
                    password = newValue;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: hideConfirmPasswordField,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: _passwordConfirmController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Confirm Password",
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hideConfirmPasswordField = !hideConfirmPasswordField;
                        });
                      },
                      icon: hideConfirmPasswordField
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please, enter your password";
                    } else if (_passwordConfirmController.text !=
                        _passwordController.text) {
                      return "Password doesn't match";
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    // save password confirm
                    passwordConfirm = newValue;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: submit,
                          child: const Text("Register"),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      TextSpan(
                        text: "Login",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const LoginScreen(),
                              ),
                            );
                          },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
