import "package:auto_route/auto_route.dart";
import "package:base_core/commons/overley_utils/dialog_util.dart";
import "package:base_core/commons/overley_utils/toast_util.dart";
import "package:base_core/cores/app_extension.dart";
import "package:base_core/di/app_data.dart";
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
                context.showPopup();
              },
              child: Text(
                "Back page",
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
                "Show Toast",
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
