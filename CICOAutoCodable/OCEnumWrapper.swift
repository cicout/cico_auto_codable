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
}

public extension OCEnumWrapper {
    enum CodingKeys: String, CodingKey {
        case rawValue
    }
}

public extension OCEnumWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawValue = try container.decode(T.RawValue.self, forKey: .rawValue)
        
        guard let _ = T.init(rawValue: rawValue) else {
            let error = NSError.init(domain: "Invalid data of \(T.self).", code: -999, userInfo: nil) as Error
            throw error
        }
        
        self.rawValue = rawValue
    }
}
