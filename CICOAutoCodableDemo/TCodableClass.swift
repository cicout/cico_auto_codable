//
//  TCodableClass.swift
//  AutoCodableDemo
//
//  Created by lucky.li on 2018/6/4.
//  Copyright © 2018 cico. All rights reserved.
//

import UIKit
import CICOAutoCodable

class TCodableClass: NSObject, CICOAutoCodable {
    private(set) var name: String?
    private(set) var stringValue: String?
//    private(set) var stringValue: Int?
    private(set) var dateValue: Date?
    private(set) var intValue: Int?
//    private(set) var intValue: String?
    private(set) var doubleValue: Double?
    private(set) var boolValue: Bool?
    private(set) var next: TCodableClass?
    private(set) var arrayValue: [String]?
    private(set) var dicValue: [String: String]?
    
    private var privateStringValue: String?
}

extension TCodableClass {
    enum CodingKeys: String, CodingKey {
        case stringValue = "string"
        case dateValue = "date"
        case intValue = "int"
        case doubleValue = "double"
        case boolValue = "bool"
        case next = "next"
        case arrayValue = "array"
        case privateStringValue = "private"

// sourcery:inline:auto:TCodableClass.CodingKeys.AutoCodable
        case name
        case dicValue
// sourcery:end
    }
}
