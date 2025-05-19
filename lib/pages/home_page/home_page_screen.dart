import 'package:auto_route/auto_route.dart';
import 'package:base_core/commons/overley_utils/dialog_util.dart';
import 'package:base_core/commons/overley_utils/toast_util.dart';
import 'package:base_core/di/app_data.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Back page',
              style: AppData(context).textTheme.s11,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ToastUtil.showToasts(
                context: context,
                title: const Text('dasd'),
                onTap: (item) {},
              );
            },
            child: Text(
              'Show Toasts',
              style: AppData(context).textTheme.s11,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // ToastUtil.showToast(
              //   context: context,
              //   backgroundColor: Colors.red,
              //   title: const Text('dasd'),
              // );
            },
            child: Text(
              'Show Toast',
              style: AppData(context).textTheme.s11,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              DialogUtil.show(context: context, child: const Text('data'));
            },
            child: Text(
              'Show Dialog',
              style: AppData(context).textTheme.s11,
            ),
          ),
        ],
      ),
    );
  }
}
