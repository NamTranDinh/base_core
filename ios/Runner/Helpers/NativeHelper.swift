import Flutter
import UIKit

class NativeHelper {
    static func setupMethodChannel(controller: FlutterViewController) {
        let methodChannel = FlutterMethodChannel(
            name: "samples.flutter.dev/native",
            binaryMessenger: controller.binaryMessenger,
        )

        methodChannel.setMethodCallHandler { (call, result) in
            if call.method == "nativeFunction" {
                result("Hello from iOS!")
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
