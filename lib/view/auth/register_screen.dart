import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen>
    with AutomaticKeepAliveClientMixin<RegisterScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool organizer = false;
  bool participants = false;
  bool agreeCheckbox = false;
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
                  "Create Your Account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildCreateAccountForm(context),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 20),
                _buildRegistrationOptions(context),
                const SizedBox(height: 20),
                _buildAgreeCheckbox(context),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle create account button press
                  },
                  child: const Text("Create Account"),
                ),
                const SizedBox(height: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Username"),
        const SizedBox(height: 7),
        TextFormField(
          controller: userNameController,
          decoration: const InputDecoration(
            hintText: "Enter your name",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your username';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildRegistrationOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Register as a"),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Organizer"),
            Checkbox(
              value: organizer,
              onChanged: (value) {
                setState(() {
                  organizer = value ?? false;
                });
              },
            ),
            const Text("Participants"),
            Checkbox(
              value: participants,
              onChanged: (value) {
                setState(() {
                  participants = value ?? false;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAgreeCheckbox(BuildContext context) {
    return Row(
      children: [
        const Text(
            "I agree with the terms and conditions by creating\nan account"),
        Checkbox(
          value: agreeCheckbox,
          onChanged: (value) {
            setState(() {
              agreeCheckbox = value ?? false;
            });
          },
        ),
      ],
    );
  }
}
