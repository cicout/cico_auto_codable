//
//  MemoryBytesWrapper.swift
//  CICOAutoCodable
//
//  Created by lucky.li on 2019/10/18.
//  Copyright © 2019 cico. All rights reserved.
//

import Foundation

/// Transfer struct memory bytes to Swift codable object;
///
/// Use for Swift Struct or C Struct only.
///
/// - WARNING: Don't use for any type contains pointer properties!!!
/// - Don't use for Swift Class or OBJ-C Class;
/// - Don't use for Collection types (Array/Dictionary/Set);
/// - Don't use for String, it is an collection of char;
/// - Don't use for any type contains string such as URL;
///
public struct StructMemoryBytesWrapper<T>: Codable {
    public var value: T

    public init?(value: T) {
        if T.self is AnyClass {
            return nil
        }
        self.value = value
    }
}

public extension StructMemoryBytesWrapper {
    enum CodingKeys: String, CodingKey {
        case data = "struct_memory_bytes"
    }
}

public extension StructMemoryBytesWrapper {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: .data)

        guard let instance = MemoryBytesAide.createInstanceFromMemoryBytes(data, type: T.self) else {
            throw CodableError.invalidData
        }

        self.value = instance
    }

    func encode(to encoder: Encoder) throws {
        let data = MemoryBytesAide.readMemoryBytes(self.value)

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
    }
}

///// Transfer class memory bytes to Swift codable object;
/////
///// - WARNING: Don't use for any type contains pointer properties!!!
///// - Don't use for Swift Class or OBJ-C Class;
///// - Don't use for Collection types (Array/Dictionary/Set);
///// - Don't use for String, it is an collection of char;
///// - Don't use for any type contains string such as URL;
/////
//public struct ClassMemoryBytesWrapper<T: AnyObject>: Codable {
//    public var value: T
//
//    public init(value: T) {
//        self.value = value
//    }
//}
//
//public extension ClassMemoryBytesWrapper {
//    enum CodingKeys: String, CodingKey {
//        case data = "class_memory_bytes"
//    }
//}
//
//public extension ClassMemoryBytesWrapper {
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let data = try container.decode(Data.self, forKey: .data)
//
//        guard let instance = MemoryBytesAide.createInstanceFromMemoryBytes(data, type: T.self) else {
//            throw CodableError.invalidData
//        }
//
//        self.value = instance
//    }
//
//    func encode(to encoder: Encoder) throws {
//        let data = MemoryBytesAide.readMemoryBytes(self.value)
//
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(data, forKey: .data)
//    }
//}
