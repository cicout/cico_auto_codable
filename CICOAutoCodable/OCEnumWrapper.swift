//
//  OCEnumWrapper.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/8/16.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

/// Transfer OBJ-C enum object to SWIFT codable object;
public struct OCEnumWrapper<T: RawRepresentable>: Codable where T.RawValue: Codable {
    public var value: T {
        set {
            self.rawValue = newValue.rawValue
        }
        get {
            return T.init(rawValue: self.rawValue)!
        }
    }
    private var rawValue: T.RawValue

    public init(value: T) {
        self.rawValue = value.rawValue
        self.value = value
    }
}

public extension OCEnumWrapper {
    public enum CodingKeys: String, CodingKey {
        case rawValue
    }
}
