import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final a = await AutoRouter.of(context).maybePop(true);
          print(a);
        },
        child: const Text('Back page'),
      ),
    );
  }
}
