//
//  UIHelper.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/6/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import UIKit

struct UIHelper {
    
    static func roundCorners(view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }
    
    static func generateWordToCountMapping(text: String) -> [String : Int] {
        var result = [String : Int]()
        var dict = [String : Int]()
        let words = text.components(separatedBy: " ")
        for word in words {
            let cleanWord = word.trimmingCharacters(in: CharacterSet(charactersIn: "-–_.,!?'…:\"")).lowercased()
            if cleanWord.count > 2 {
                if var count = dict[cleanWord] {
                    count += 1
                    dict[cleanWord] = count
                    if count > 10 {
                        result[cleanWord] = count
                    }
                } else {
                    dict[cleanWord] = 1
                }
            }
        }
        return result
    }
    
    static func getHoursFromDate(date: Date?) -> String {
        var result = ""
        if let d = date {
            let current = Date()
            let calendar = Calendar.current
            let start = calendar.component(.hour, from: d)
            let end = calendar.component(.hour, from: current)
            let interval = end - start
            if interval < 24 {
                if interval <= 0 {
                    result = "Less than an hour"
                } else {
                    result = "\(interval)" + " " + (interval == 1 ? "hour" : "hours")
                }
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM, HH:mm"
                result = dateFormatter.string(from: d)
            }
        }
        return result
    }
}
