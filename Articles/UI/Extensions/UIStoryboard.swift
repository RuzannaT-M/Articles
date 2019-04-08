//
//  UIStoryboard.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/6/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import UIKit

enum StoryModule : String {
    case main = "Main"
}

extension UIStoryboard {
    
    class func instantiateController<T>(forModule module : StoryModule = .main) -> T {
        let storyboard = UIStoryboard.init(name: module.rawValue, bundle: nil);
        let name = NSStringFromClass(T.self as! AnyClass).components(separatedBy: ".").last
        return storyboard.instantiateViewController(withIdentifier: name!) as! T
    }
}
