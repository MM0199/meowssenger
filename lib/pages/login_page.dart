import 'package:chat_app/components/Navigation/transition.dart';
import 'package:chat_app/components/widget/custom_button.dart';
import 'package:chat_app/pages/sign_up_name_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TransitionHandler transition = TransitionHandler();
  final FocusNode _focusNode = FocusNode();
  bool rememberMe = false;
  bool _isFocused = false;
  bool _obscured = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleLogin() {
    String username = usernameController.text;
    String password = passwordController.text;
    FocusScope.of(context).unfocus();

    if (username == 'user' && password == 'password') {
      Navigator.push(context, transition.navigateToPage('rl', const SignUpNamePage()) as Route<Object?>);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content:
                  const Text('Invalid username or password. Please try again'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK')),
              ],
            );
          });
    }
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (_focusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      _focusNode.canRequestFocus = false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      body: Center(
        child: SingleChildScrollView(
          child: _signIn(),
        ),
      ),
    );
  }

  Column _signIn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        SizedBox(
          width: 300.0,
          height: 300.0,
          child: Image.asset(
            'assets/icons/meow_icon.png',
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 15.0),
        const Text(
          'Welcome to Meowssenger\nSign in to Get Started',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 50.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Color(0xFF333333),
                // Clear the default label text
                hintText: 'Email',
                hintStyle: TextStyle(color: Color(0xFF888888), fontSize: 20.0),
                // Clear the default prefix icon
                prefixIcon: null,
              )),
        ),
        const SizedBox(height: 3.0),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: TextField(
              controller: passwordController,
              obscureText: _obscured,
              focusNode: _focusNode,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0)),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Color(0xFF333333),
                // Clear the default label text
                hintText: 'Password',
                hintStyle: const TextStyle(color: Color(0xFF888888), fontSize: 20.0),
                // Clear the default prefix icon
                prefixIcon: null,
                suffixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                  child: GestureDetector(
                    onTap: _toggleObscured,
                    child: Icon(
                      _obscured
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      size: 24,
                    ),
                  ),
                )
              )),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: (bool? newValue) {
                setState(() {
                  rememberMe = newValue!;
                });
              },
              shape: const CircleBorder(),
            ),
            const Text(
              'Save login info',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          width: double.infinity,
          height: 60.0,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: CustomButton(
            text: 'Login',
            onPressed: () => _handleLogin(),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          width: double.infinity,
          height: 60.0,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: CustomButton(
            text: 'Create New Account',
            onPressed: () {
              Navigator.push(context, transition.navigateToPage('rl', const SignUpNamePage()) as Route<Object?>);
            },
          )
        ),
        const SizedBox(height: 20.0),
        const Text(
          'Forgotten Your Password?',
          style: TextStyle(
              color: Colors.blue, fontSize: 17.0, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
