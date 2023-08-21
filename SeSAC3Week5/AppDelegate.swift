//
//  AppDelegate.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //2. 부가기능 열기
        UNUserNotificationCenter.current().delegate = self
        
        //1. 알림 권한 설정 - requestAuthorization 옵션키 누르고 부르기, 옵션은 보통 3개 / 허용했으면 포스터 뷰컨으로
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            print(success, error)
        }
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //willPresent: 포그라운드 상태에서 알림 띄우기 -> 친구랑 1:1 채팅 중에, 다른 대화방 알림은 위에 뜸!
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //특정 화면, 특정 조건에서만 포그라운드 알림 받기,
        //특정 화면에서는 알림 안 받기 이런 처리 가능
        completionHandler([.sound, .badge, .banner, .list]) //배너? 리스트? 새롭게 생긴 스타일...
    }
    
    //알림을 클릭하면 특정 화면으로 이동하는 경우(채팅알림이면 채팅방 이동, 쿠팡광고푸쉬면 광고 사이트로 이동 등)
    //Local 알림 개수 제한: 하루에 64개(identifier기반)
    //카톡: 포그라운드로 앱을 켜는 순간(알림 누를 경우) 기존 쌓여있던 모든 알림 다 사라짐
    //잔디나 인스타는 그래도 남아있더라 카톡과 설정이 다르더라

}
