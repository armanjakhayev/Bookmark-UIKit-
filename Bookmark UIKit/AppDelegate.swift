import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        if Storage.showOnboarding {
            self.window?.rootViewController = UINavigationController(rootViewController: WelcomeView())
        } else {
            self.window?.rootViewController = UINavigationController(rootViewController: MainView())
        }
        return true
    }


}

