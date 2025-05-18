import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let channelName = "com.ekades.operatortracker"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  let controller = window?.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

      channel.setMethodCallHandler { call, result in
        if call.method == "getDeviceId" {
          if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            result(uuid)
          } else {
            result(FlutterError(code: "UNAVAILABLE", message: "Device ID unavailable", details: nil))
          }
        } else {
          result(FlutterMethodNotImplemented)
        }
      }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
