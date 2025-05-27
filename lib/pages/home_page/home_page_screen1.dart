import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePageScreen1 extends StatelessWidget {
  const HomePageScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Back page'),
        ),
      ),
    );
  }
}
