//
//  MyClass.swift
//  CICOAutoCodable
//
//  Created by lucky.li on 2018/8/7.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation
import CICOAutoCodable

enum MyEnum: String, CICOAutoCodable {
    case one
    case two
}

class MyClass: CICOAutoCodable {
    private(set) var stringValue: String?
    private(set) var dateValue: Date?
    private(set) var intValue: Int = 0
    private(set) var doubleValue: Double = 1.0
    private(set) var boolValue: Bool = false
    private(set) var enumValue: MyEnum = .one
    private(set) var urlValue: URL?
    private(set) var next: MyClass?
    private(set) var arrayValue: [String]?
    private(set) var dicValue: [String: String]?
    private(set) var ignoredValue: String?

//// sourcery:inline:auto:MyClass.CICOAutoCodable_Auto_Generated_CodingKeys_Head
//    enum CodingKeys: String, CodingKey {
//// sourcery:inline:auto:MyClass.CodingKeys.CICOAutoCodable_Auto_Generated_Custom_CodingKeys
//        case next = "nextValue"
//// sourcery:inline:auto:MyClass.CodingKeys.CICOAutoCodable_Auto_Generated_CodingKeys
//        case stringValue
//        case dateValue
//        case intValue
//        case doubleValue
//        case boolValue
//        case enumValue
//        case urlValue
//        case arrayValue
//        case dicValue
//// sourcery:inline:auto:MyClass..CICOAutoCodable_Auto_Generated_CodingKeys_Tail
//    }
//// sourcery:end
}

//extension MyClass {
//    enum CICOCustomCodingKeys: String {
//        case next = "nextValue"
//    }
//
//    enum CICOIgnoredCodingKeys: String {
//        case ignoredValue
//    }
//}

extension MyClass {
    enum CICOIgnoredCodingKeys: String {
        case ignoredValue
    }

    enum CodingKeys: String, CodingKey {
        case next = "nextValue"

// sourcery:inline:auto:MyClass.CodingKeys.CICOAutoCodable_Auto_Generated_CodingKeys
        case stringValue
        case dateValue
        case intValue
        case doubleValue
        case boolValue
        case enumValue
        case urlValue
        case arrayValue
        case dicValue
// sourcery:end
    }
}
