import UIKit
import Flutter
import JIRAMobileConnect


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var channel : FlutterMethodChannel?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    let PLATFORM_CHANNEL = FlutterMethodChannel.init(name: "flutter.native/helper", binaryMessenger: controller);
    
    PLATFORM_CHANNEL.setMethodCallHandler({
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
        if ("helloFromNativeCode" == call.method) {
            print("Hello printed from native?")
            JMC.sharedInstance().configureJiraConnect("URL",
                                                      projectKey: "PROJECTKEY", apiKey: "API_KEY")
            
            if let vc = JMC.sharedInstance()?.viewController(){
                controller.present(vc, animated: true, completion: nil)
            }
            result("Are we done?")
        }
        else {
            result(FlutterMethodNotImplemented)
        }
    })
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
