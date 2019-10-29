//
//  SerializableWrapper.swift
//  CICOAutoCodable
//
//  Created by lucky.li on 2019/10/26.
//  Copyright © 2019 cico. All rights reserved.
//

import Foundation

/// Transfer Serializable value to Codable.
///
/// - Write "extension YourType: NSCodingSerializable {}" first, then you can use it for NSCoding value;
/// - You can directly use it for NSArray<Element: NSCoding> value;
///
public struct SerializableWrapper<T: Serializable>: Codable {
    public var value: T

    public init(value: T) {
        self.value = value
    }
}

public extension SerializableWrapper {
    enum CodingKeys: String, CodingKey {
        case data
    }
}

public extension SerializableWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: .data)

        guard let value = T.createFromSerializedData(data) else {
            throw CodableError.decodeFailed
        }

        self.value = value
    }

    func encode(to encoder: Encoder) throws {
        guard let data = self.value.serializToData() else {
            throw CodableError.encodeFailed
        }

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
    }
}
