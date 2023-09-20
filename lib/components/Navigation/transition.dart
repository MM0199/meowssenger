import 'package:flutter/material.dart';

class TransitionHandler {

    PageRouteBuilder<dynamic>? navigateToPage(String direction, dynamic destPage){
      switch (direction) {
        case 'rl':
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
        case 'lr':
          return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => destPage,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1.0, 0.0); // Define the start position
                const end = Offset.zero; // Define the end position
                const curve = Curves.easeInOut; // Define the animation curve

                var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              });
        default:
          return null;
      }
  }
}