import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller:FlutterViewController = window.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.jj.platinum", binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler{ (call, result) in
        print("flutter 给到我 method:\(call.method) arguments:\(call.arguments)")
        if "callNativeMethond" == call.method{
            result(1);
        }
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
}
