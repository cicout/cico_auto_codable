//
//  CStructWrapper.swift
//  CICOAutoCodable
//
//  Created by lucky.li on 2019/1/14.
//  Copyright © 2019 cico. All rights reserved.
//

import Foundation

/// Transfer C Struct object to SWIFT codable object;
public struct CStructWrapper<T: Any>: Codable {
    public var value: T
    
    public init(value: T) {
        self.value = value
    }
}

public extension CStructWrapper {
    public enum CodingKeys: String, CodingKey {
        case data
    }
}

public extension CStructWrapper {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: .data)
        
        self.value = data.withUnsafeBytes { (ptr: UnsafePointer<CChar>) -> T in
            let size = MemoryLayout<T>.size
            return ptr.withMemoryRebound(to: T.self, capacity: size, { (valuePtr) -> T in
                return valuePtr.pointee
            })
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var currentValue = self.value
        let data = withUnsafeBytes(of: &currentValue) { (ptr) -> Data in
            return Data.init(bytes: ptr)
        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
    }
}
