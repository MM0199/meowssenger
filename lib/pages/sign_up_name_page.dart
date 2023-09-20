import 'package:chat_app/components/widget/custom_button.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/sign_up_password_page.dart';
import 'package:flutter/material.dart';

import '../components/Navigation/transition.dart';

class SignUpNamePage extends StatefulWidget {
  const SignUpNamePage({super.key});

  @override
  _SignUpNameState createState() => _SignUpNameState();
}

class _SignUpNameState extends State<SignUpNamePage> {
  TextEditingController nameController = TextEditingController();
  TransitionHandler transition = TransitionHandler();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isShow = false;

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
    String name = nameController.text;
    FocusScope.of(context).unfocus();
    if (name.isNotEmpty) {
      _isShow = false;
      Navigator.push(context, _rightToLeft(const SignUpPasswordPage()));
    } else {
      _isShow = true;
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
            'What\'s your name?',
            style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w900,
                color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15.0),
          child: TextField(
            controller: nameController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: const Color(0xFF333333),
              labelText: 'Full name',
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
            margin: const EdgeInsets.all(15.0),
            child: const Text(
              'Name cannot be empty',
              style: TextStyle(
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
            onPressed: () {
              Navigator.push(context, transition.navigateToPage('rl', const SignUpPasswordPage()) as Route<Object?>);
            },
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
          Navigator.push(context, transition.navigateToPage('lr', const LoginPage()) as Route<Object?>);
        },
        child: const Icon(
          Icons.arrow_back,
          size: 30.0,
        ),
      ),
    );
  }

  PageRouteBuilder<dynamic> _rightToLeft(destPage) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Define the start position
          const end = Offset.zero; // Define the end position
          const curve = Curves.easeInOut; // Define the animation curve

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        });
  }
}
