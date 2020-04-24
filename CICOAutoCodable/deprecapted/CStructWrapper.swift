//
//  CStructWrapper.swift
//  CICOAutoCodable
//
//  Created by lucky.li on 2019/1/14.
//  Copyright © 2019 cico. All rights reserved.
//

import Foundation

/// @available(*, deprecated, message: "Use \"StructMemoryBytesWrapper\" instead.")
public struct CStructWrapper<T: Any>: Codable {
    public var value: T

    public init(value: T) {
        self.value = value
    }

    enum CodingKeys: String, CodingKey {
        case data = "c_struct_data"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: .data)

        let size = MemoryLayout<T>.size
        guard data.count == size else {
            print("[ERROR]: Invalid data size for CStructWrapper.")
            throw CodableError.decodeFailed
        }

        self.value = try data.withUnsafeBytes({ (rawBufferPointer) -> T in
            let typeBufferPointer = rawBufferPointer.bindMemory(to: T.self)

            guard let typePointer = typeBufferPointer.baseAddress else {
                print("[ERROR]: Invalid data for CStructWrapper.")
                throw CodableError.decodeFailed
            }

            return typePointer.pointee
        })
    }

    public func encode(to encoder: Encoder) throws {
        let data = withUnsafeBytes(of: self.value) { (rawBufferPointer) -> Data in
            return Data.init(rawBufferPointer)
        }

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
    }
}
