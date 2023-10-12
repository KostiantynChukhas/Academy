//
//  AlertHelper.swift
//  Academy
//
//  Created by Sergey Pritula on 17.04.2021.
//

import UIKit

class AlertHelper {
    private class func getTopController(from: UIViewController? = nil) -> UIViewController? {
        if let controller = from {
            return controller
        } else if var controller = UIApplication.shared.windows.first?.rootViewController {
            while let presented = controller.presentedViewController {
                controller = presented
            }
            
            return controller
        }
        
        return nil
    }
    
    class func showAlert(
        _ title: String = "Ошибка",
        msg: String?,
        from: UIViewController? = nil,
        completion: SimpleClosure<Bool>? = nil
    ) {
        let title = title
        let message = msg ?? ""
        
        DispatchQueue.main.async {
            guard let root = getTopController(from: from) else { return }
            
            let alert = AlertViewController.instantiate(with: title, and: message)
            root.present(alert, animated: true, completion: nil)
        }
    }
    
}
