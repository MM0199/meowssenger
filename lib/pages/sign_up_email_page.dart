import 'package:chat_app/components/Navigation/transition.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/sign_up_password_page.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../components/widget/custom_button.dart';

class SignUpEmailPage extends StatefulWidget {
  const SignUpEmailPage({super.key});

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmailPage> {
  TextEditingController emailController = TextEditingController();
  TransitionHandler transition = TransitionHandler();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isShow = false;
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
    String email = emailController.text;
    FocusScope.of(context).unfocus();
    if (EmailValidator.validate(email)) {
      _isShow = false;
      Navigator.push(context, transition.navigateToPage('rl', const LoginPage()) as Route<Object?>);
    } else {
      _isShow = true;
      _message = 'Please enter a valid email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      appBar: _appBar(context),
      body: _bodySection(context),
    );
  }

  Column _bodySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15.0),
          child: const Text(
            'Enter your Email',
            style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w900,
                color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15.0),
          child: TextField(
            controller: emailController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: const Color(0xFF333333),
              labelText: 'Email',
              floatingLabelBehavior: _isFocused
                  ? FloatingLabelBehavior.always
                  : FloatingLabelBehavior.never,
              labelStyle: TextStyle(
                color: _isFocused ? Colors.white : const Color(0xFF888888),
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isShow && !_isFocused,
          child: Container(
            margin: const EdgeInsets.only(left: 15.0),
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
          margin: !_isShow
              ? const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0)
              : const EdgeInsets.all(15.0),
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
          Navigator.push(context, transition.navigateToPage('lr', const SignUpPasswordPage()) as Route<Object?>);
        },
        child: const Icon(
          Icons.arrow_back,
          size: 30.0,
        ),
      ),
    );
  }
}
