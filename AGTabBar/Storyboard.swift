//
//  Storyboard.swift
//  App
//
//  Created by ahmed gado on 06/01/2021.
//  Copyright © 2021 ahmed gado. All rights reserved.
//

import Foundation
import UIKit
public enum Storyboard: String {
    //storyBoards in APP
    case Main
    public func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC {
        guard
            let vc = UIStoryboard(name: self.rawValue, bundle: nil)
                .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
            
            else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)") }
        return vc
    }

    public func initialViewController() -> UIViewController {
        let story = UIStoryboard(name: self.rawValue, bundle: nil)
        
        guard let vc = story.instantiateInitialViewController() else { fatalError("\(self.rawValue) has no InitialViewController") }
        return vc
    }
}

extension UIViewController {
    
    class func fromStoryboard() -> Self {
        let storyboardName = ("\(type(of: self))" as NSString).components(separatedBy: ".").first ?? "Main"
        return instantiateFromStoryboardHelper(type: self, storyboardName: storyboardName)
    }
    
    class func fromStoryboard(_ storyboardName: String) -> Self {
        return instantiateFromStoryboardHelper(type: self, storyboardName: storyboardName)
        
    }
    
    private class func instantiateFromStoryboardHelper<T>(type: T.Type, storyboardName: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! T
        return controller
    }
    
}



internal extension UIViewController {
    
    /// Create a new empty controller instance with given view
    ///
    /// - Parameters:
    ///   - view: view
    ///   - frame: frame
    /// - Returns: instance
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }
    
}

extension UIViewController {
    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
    
    
}
