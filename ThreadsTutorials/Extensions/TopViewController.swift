//
//  TopViewController.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/27.
//

import SwiftUI


extension UIWindow {
    static func getTopViewController() -> UIViewController? {
        
        
//        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        
        if var topController = window?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
