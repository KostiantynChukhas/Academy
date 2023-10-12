//
//  Storyboard.swift
//  Hydra_iOS
//
//  Created by  on 18.03.2021.
//

import UIKit

enum Storyboard {
    static let profile = storyboard(name: "Profile")
    static let login = storyboard(name: "Login")
    static let registration = storyboard(name: "Registration")
    static let smsVerification = storyboard(name: "SmsVerification")
    static let home = storyboard(name: "Home")
    static let menu = storyboard(name: "Menu")
    static let detail = storyboard(name: "Detail")
    static let alert = storyboard(name: "Alert")
    static let noInternet = storyboard(name: "NoInternetConnection")
    static let schedule = storyboard(name: "Schedule")
    static let scheduleDetail = storyboard(name: "ScheduleDetail")
    static let scheduleFilter = storyboard(name: "ScheduleFilter")
    static let contacts = storyboard(name: "Contacts")
    static let coaches = storyboard(name: "Coaches")
    static let filterCoaches = storyboard(name: "FilterCoaches")
    static let detailCoaches = storyboard(name: "DetailCoaches")
    static let myCards = storyboard(name: "MyCards")
    static let groupCards = storyboard(name: "GroupCards")
    static let scheduleCategory = storyboard(name: "ScheduleCategory")
    
    
}

private func storyboard(name: String, bundle: Bundle? = nil) -> UIStoryboard {
    return UIStoryboard(name: name, bundle: bundle)
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

// MARK: - UIStoryboard + instantiate -

extension UIStoryboard {
    func instantiate<T: StoryboardIdentifiable>() -> T {
        guard let controller = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Controller is nil with the identifier: \(T.storyboardIdentifier)")
        }
        return controller
    }
}

// MARK: - StoryboardIdentifiable -

extension UIViewController: StoryboardIdentifiable {}


// MARK: - StoryboardIdentifiable where Self: UIViewController -

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self.self)
    }
}
