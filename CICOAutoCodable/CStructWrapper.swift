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
        case data = "c_struct_data"
    }
}

public extension CStructWrapper {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: .data)
        
        let size = MemoryLayout<T>.size
        guard data.count == size else {
            let error = NSError.init(domain: "Invalid data of \(T.self).", code: -999, userInfo: nil) as Error
            throw error
        }
        
        self.value = data.withUnsafeBytes { (ptr: UnsafePointer<T>) -> T in
            return ptr.pointee
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        let data = withUnsafeBytes(of: self.value) { (ptr) -> Data in
            return Data.init(bytes: ptr)
        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
    }
}
