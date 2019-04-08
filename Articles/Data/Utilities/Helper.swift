//
//  Helper.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/6/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation

struct Helper {

    static func getWordsFromText(_ text: String?) -> [String] {
        var result = [String]()
        if let str = text, !str.isEmpty {
            let arr = str.components(separatedBy: " ")
            for tag in arr {
                let cleanWord = tag.trimmingCharacters(in: CharacterSet(charactersIn: "–-_.,!?'…:\"")).lowercased()
                if !cleanWord.isEmpty {
                    result.append(cleanWord)
                }
            }
        }
        return result
    }
}
