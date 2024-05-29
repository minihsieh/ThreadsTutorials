//
//  ShareView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/27.
//

import SwiftUI


// 如果用UIViewControllerRepresentable的話，設定detents只會出現第一個設定而已
//struct ShareView: UIViewControllerRepresentable {
//    
//    var activityItems: [Any]
//    var applicationActivities: [UIActivity]? = nil
//    
//    func makeUIViewController(context: Context) -> some UIViewController {
//        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
//        return activityController
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
////        if let presentationController = uiViewController.presentationController as? UISheetPresentationController {
////            presentationController.detents = [.medium(), .large()]
////            presentationController.prefersGrabberVisible = true
////        }
////        
//    }
//}


class ShareView {
    static let shared = ShareView()
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    var activityItems: [Any] = []
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    
    func open(callback: Callback? = nil) {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        UIWindow.getTopViewController()?.present(controller, animated: true, completion: nil)
    }
}


struct ShareSheetView: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void

    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}
