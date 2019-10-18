//
//  OCCodingObjectWrapper.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/8/16.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

/// Transfer OBJ-C NSCoding object to SWIFT codable object;
public struct OCCodingObjectWrapper<T: NSCoding>: Codable {
    public var value: T

    public init(value: T) {
        self.value = value
    }
}

public extension OCCodingObjectWrapper {
    enum CodingKeys: String, CodingKey {
        case data
    }
}

public extension OCCodingObjectWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: .data)

        guard let value = NSKeyedUnarchiver.unarchiveObject(with: data) as? T else {
            throw CodableError.invalidData
        }

        self.value = value
    }

    func encode(to encoder: Encoder) throws {
        let data = NSKeyedArchiver.archivedData(withRootObject: value)

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
    }
}
