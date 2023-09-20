import 'package:chat_app/components/Navigation/transition.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/sign_up_email_page.dart';
import 'package:chat_app/pages/sign_up_name_page.dart';
import 'package:flutter/material.dart';

import '../components/widget/custom_button.dart';

class SignUpPasswordPage extends StatefulWidget {
  const SignUpPasswordPage({super.key});

  @override
  _SignUpPasswordState createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TransitionHandler transition = TransitionHandler();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isShow = false;
  bool _obscured = false;
  String _message = '';

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

  void _handleInput() {
    String password = passwordController.text;
    FocusScope.of(context).unfocus();

    if (password.length > 5) {
      _isShow = false;
      Navigator.push(context, transition.navigateToPage('rl', const SignUpEmailPage()) as Route<Object?>);
    } else {
      _isShow = true;
      _message = 'Password must contain at least 6 characters.';
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
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  Column _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15.0),
          child: const Text(
            'Create a password',
            style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w900,
                color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15.0),
          child: const Text(
            'Create a password with at least 6 letters or numbers.'
            ' It should be something others can\'t guess.',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15.0),
          child: TextField(
            controller: passwordController,
            obscureText: _obscured,
            focusNode: _focusNode,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFF333333),
                labelText: 'Password',
                floatingLabelBehavior: _isFocused
                    ? FloatingLabelBehavior.always
                    : FloatingLabelBehavior.never,
                labelStyle: TextStyle(
                  color: _isFocused ? Colors.white : const Color(0xFF888888),
                  fontSize: 18.0,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                  child: GestureDetector(
                    onTap: _toggleObscured,
                    child: Icon(
                      _obscured
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      size: 24,
                    ),
                  ),
                )),
          ),
        ),
        Visibility(
          visible: _isShow && !_isFocused,
          child: Container(
            margin: const EdgeInsets.all(15.0),
            child: Text(
              _message,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
          height: 60,
          width: double.infinity,
          child: CustomButton(
            text: 'Next',
            onPressed: _handleInput,
          ),
        ),
        Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, transition.navigateToPage('lr', const LoginPage()) as Route<Object?>);
              },
              child: const Text(
                'Already have an account?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.blue),
              ),
            ))
      ],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF222222),
      elevation: 0.0,
      leading: GestureDetector(
        onTap: () {
          Navigator.push(context, transition.navigateToPage('lr', const SignUpNamePage()) as Route<Object?>);
        },
        child: const Icon(
          Icons.arrow_back,
          size: 30.0,
        ),
      ),
    );
  }
}
