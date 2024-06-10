import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_and_note/services/auth_http_services.dart';
import 'package:todo_and_note/view/screens/auth/register_screen.dart';
import 'package:todo_and_note/view/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();
  bool isLoading = false;

  String? email;
  String? password;

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });

      try {
        await _authHttpServices.login(email!, password!);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return const HomeScreen();
            },
          ),
        );
      } on Exception catch (e) {
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
        title: const Text("Login"),
      ),
      body: Form(
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
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  prefixIcon: Icon(Icons.password),
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
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
                        child: const Text("Login"),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Don't have an account yet? ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    TextSpan(
                      text: "Register",
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
                              builder: (ctx) => const RegisterScreen(),
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
    );
  }
}
