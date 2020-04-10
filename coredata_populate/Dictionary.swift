//
//  Dictionary.swift
//  coredata_populate
//
//  Created by Alexey Smirnov on 4/10/20.
//  Copyright © 2020 Alexey Smirnov. All rights reserved.
//

import Foundation

func arrayFromContentsOfFileWithName(fileName: String) -> [String]? {
    guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
        return nil
    }
    
    do {
        let content = try String(contentsOfFile:path, encoding: .utf8)
        return content.components(separatedBy: "\n")
    } catch _ as NSError {
        return nil
    }
}

struct DictionaryRow: Hashable, Codable {
    var character: String
    var definition: String?
}

