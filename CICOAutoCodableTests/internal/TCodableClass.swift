//
//  TCodableClass.swift
//  AutoCodableDemo
//
//  Created by lucky.li on 2018/6/4.
//  Copyright © 2018 cico. All rights reserved.
//

import CICOAutoCodable

public class TCodableClass: CICOAutoCodable {
    private(set) var name: String?
    private(set) var stringValue: String?
    private(set) var dateValue: Date?
    private(set) var intValue: Int = 1
    private(set) var doubleValue: Double?
    private(set) var boolValue: Bool?
    private(set) var next: TCodableClass?
    private(set) var arrayValue: [String]?
    private(set) var dicValue: [String: String]?

    private var privateStringValue: String?
    private var url: URL?

    var testInt: Int! = 0

    public required init(from decoder: Decoder) throws {

    }
}

extension TCodableClass {
    enum CICOCustomCodingKeys: String {
        case stringValue = "string"
        case dateValue = "date"
        case intValue = "int"
        case doubleValue = "double"
        case boolValue = "bool"
        case arrayValue = "array"
        case privateStringValue = "private"
    }

// sourcery:inline:auto:TCodableClass.CICOAutoCodable_Auto_Generated_CodingKeys_Head
    enum CodingKeys: String, CodingKey {
// sourcery:inline:auto:TCodableClass.CodingKeys.CICOAutoCodable_Auto_Generated_Custom_CodingKeys
        case stringValue = "string"
        case dateValue = "date"
        case intValue = "int"
        case doubleValue = "double"
        case boolValue = "bool"
        case arrayValue = "array"
        case privateStringValue = "private"
// sourcery:inline:auto:TCodableClass.CodingKeys.CICOAutoCodable_Auto_Generated_CodingKeys
        case name
        case next
        case dicValue
        case url
        case testInt
// sourcery:inline:auto:TCodableClass.CICOAutoCodable_Auto_Generated_CodingKeys_Tail
    }
// sourcery:end
}

extension TCodableClass: AutoEquatable {}
