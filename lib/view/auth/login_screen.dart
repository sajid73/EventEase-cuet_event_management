import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with AutomaticKeepAliveClientMixin<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool stayLoggedIn = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Login to Your Account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildLoginForm(context),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle login button press
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Email Address"),
        const SizedBox(height: 7),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: "Enter your email",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        const Text("Password"),
        const SizedBox(height: 7),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: "Enter your password",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text("Stay Logged In"),
            Checkbox(
              value: stayLoggedIn,
              onChanged: (value) {
                setState(() {
                  stayLoggedIn = value ?? false;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text("Forgot Password?"),
      ],
    );
  }
}
