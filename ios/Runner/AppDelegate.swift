import UIKit
import Flutter
import workmanager
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyChqHpJgqUTljz0oqF92Gb0Oxspfm50S-8")
    WorkmanagerPlugin.registerTask(withIdentifier: "task-identifier")
    GeneratedPluginRegistrant.register(with: self)
    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
