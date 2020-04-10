//
//  OCEnumWrapper.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/8/16.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

/// @available(*, deprecated, message: "Use \"extension EnumType: Codable {}\" instead.")
public struct OCEnumWrapper<T: RawRepresentable>: Codable where T.RawValue: Codable {
    public var value: T {
        set {
            self.rawValue = newValue.rawValue
        }
        get {
            guard let value = T.init(rawValue: self.rawValue) else {
                fatalError("Invalid raw value of \(T.self).")
            }
            return value
        }
    }
    private var rawValue: T.RawValue

    public init(value: T) {
        self.rawValue = value.rawValue
        self.value = value
    }

    enum CodingKeys: String, CodingKey {
        case rawValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawValue = try container.decode(T.RawValue.self, forKey: .rawValue)

        guard T.init(rawValue: rawValue) != nil else {
            throw CodableError.decodeFailed
        }

        self.rawValue = rawValue
    }
}
