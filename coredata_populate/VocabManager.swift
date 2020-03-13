//
//  Data.swift
//  lanternhsk
//
//  Created by Alexey Smirnov on 12/15/19.
//  Copyright © 2019 Alexey Smirnov. All rights reserved.
//

import UIKit
import SwiftUI

let lists: [VocabDeck] = [
    VocabDeck(id: 1, name: "HSK 1", filename: "HSK1.csv", wordCount: 150),
    VocabDeck(id: 2, name: "HSK 2", filename: "HSK2.csv", wordCount: 150),
    VocabDeck(id: 3, name: "HSK 3", filename: "HSK3.csv", wordCount: 300),
    VocabDeck(id: 4, name: "HSK 4", filename: "HSK4.csv", wordCount: 600),
    VocabDeck(id: 5, name: "HSK 5", filename: "HSK5.csv", wordCount: 1300),
    VocabDeck(id: 6, name: "HSK 6", filename: "HSK6.csv", wordCount: 2500),
]

struct VocabCard: Hashable, Codable, Identifiable {
    var id: Int
    var wordSimp: String
    var wordTrad: String
    var pinyin: String
    var translation: String
}

// https://www.purpleculture.net/textbook-vocab-lists/

struct VocabDeck: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var filename: String
    var wordCount: Int
    
    func loadCSV() -> [VocabCard] {
        var items = [VocabCard]()
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        let dataString: String! = String.init(data: data, encoding: .utf8)
        let lines: [String] = dataString.components(separatedBy: NSCharacterSet.newlines) as [String]

        for line in lines {
            var values: [String] = []
            if line != "" {
                if line.range(of: "\"") != nil {
                    var textToScan:String = line
                    var value:String?
                    var textScanner:Scanner = Scanner(string: textToScan)
                    while textScanner.string != "" {
                        if (textScanner.string as NSString).substring(to: 1) == "\"" {
                            textScanner.currentIndex = textScanner.string.index(after: textScanner.currentIndex)
                            value = textScanner.scanUpToString("\"")
                            textScanner.currentIndex = textScanner.string.index(after: textScanner.currentIndex)
                        } else {
                            value = textScanner.scanUpToString(",")
                        }

                         values.append(value ?? "")

                         if textScanner.currentIndex < textScanner.string.endIndex {
                            textScanner.currentIndex = textScanner.string.index(after: textScanner.currentIndex)
                            textToScan = String(textScanner.string[textScanner.currentIndex...])
                         } else {
                             textToScan = ""
                         }
                         textScanner = Scanner(string: textToScan)
                    }

                    // For a line without double quotes, we can simply separate the string
                    // by using the delimiter (e.g. comma)
                } else  {
                    values = line.components(separatedBy: ",")
                }
            }
            
            if values.count > 0 {
                items.append(VocabCard(id: Int(values[1])!, wordSimp: values[2], wordTrad: values[3], pinyin: values[4], translation: values[5]))
            }
        }
        
        return items
    }
    
}



