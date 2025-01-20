//
//  LockedCaptureTestApp.swift
//  LockedCaptureTest
//
//  Created by ByteDance on 2025/1/17.
//

import SwiftUI
import LockedCameraCapture

@main
struct LockedCaptureTestApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 在这里配置首次启动时的数据加载等操作
        return true
    }


    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//        print(userActivity.activityType)
//        print("continue userActivity")

        return true
    }
    
    func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
//        print(userActivityType)
//        print("willContinueUserActivityWithType")
        return true
    }
    
    func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: any Error) {
//        print(userActivityType)
//        print("didFailToContinueUserActivityWithType")
    }
    
    func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
//        print(userActivity.activityType)
//        if let info = userActivity.userInfo?["LockExtensionInfo"] {
//            print(info)
//        }
//        if (userActivity.activityType == NSUserActivityTypeLockedCameraCapture){
//            print("didUpdate userActivity")
//        }
    }
}
