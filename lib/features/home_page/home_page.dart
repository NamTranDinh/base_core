import "package:auto_route/auto_route.dart";
import "package:base_core/commons/overley_utils/dialog_util.dart";
import "package:base_core/commons/overley_utils/toast_util.dart";
import "package:base_core/cores/constants/app_extension.dart";
import "package:base_core/cores/dependency_injection/app_data.dart";
import "package:flutter/material.dart";
import "package:toastification/toastification.dart";

@RoutePage(name: "HomePageRouter")
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      backgroundColor: AppData(context).color.background,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.showAppAlert();
              },
              child: Text(
                "Show custom toast (App Alert)",
                style: AppData(context).textStyle.s14,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final ctx = context..showLoading();
                Future.delayed(const Duration(seconds: 3), ctx.hideLoading);
              },
              child: Text(
                "Show loading",
                style: AppData(context).textStyle.s14,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ToastUtil.showSnackBar(
                  context: context,
                  title: const Text("dasd"),
                  onTap: (ToastificationItem item) {},
                );
              },
              child: Text(
                "Show Snack Bar",
                style: AppData(context).textStyle.s14,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ToastUtil.showToast(
                  context: context,
                  backgroundColor: Colors.red,
                  title: const Text("dasd"),
                );
              },
              child: Text(
                "Show Alert",
                style: AppData(context).textStyle.s14,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await DialogUtil.show(
                  context: context,
                  child: const Text("data"),
                );
              },
              child: Text(
                "Show Dialog",
                style: AppData(context).textStyle.s14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
