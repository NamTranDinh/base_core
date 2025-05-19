import 'package:auto_route/auto_route.dart';
import 'package:base_core/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'PageNotFoundRouter')
class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404 - Page Not Found')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              "Oops! The page you're looking for doesn't exist.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.router.replaceAll([const SplashRoute()]),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
