//
//  OCEnumWrapper.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/8/16.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

public struct OCEnumWrapper<T: RawRepresentable>: Codable where T.RawValue: Codable {
    public var value: T {
        set {
            self.rawValue = newValue.rawValue
        }
        get {
            return T.init(rawValue: rawValue)!
        }
    }
    private var rawValue: T.RawValue!

    public init(value: T) {
        self.value = value
    }
}

public extension OCEnumWrapper {
    public enum CodingKeys: String, CodingKey {
        case rawValue
    }
}
