//
//  MemoryBytes.swift
//  CICOAutoCodable
//
//  Created by lucky.li on 2019/10/15.
//  Copyright © 2019 cico. All rights reserved.
//

import Foundation

public class MemoryBytesAide {
    public static func createInstanceFromMemoryBytes<T>(_ bytes: Data, type: T.Type) -> T? {
        let size = MemoryLayout<T>.size
        guard bytes.count == size else {
            print("[ERROR]: Invalid memory bytes for \(type): bytes.count = \(bytes.count), \(type).size = \(size).")
            return nil
        }

        return bytes.withUnsafeBytes({ (rawBufferPointer) -> T in
            return rawBufferPointer.load(as: T.self)
        })
    }

    public static func readMemoryBytes<T>(_ instance: T) -> Data {
        return self.readStructMemoryBytes(instance)
    }

    public static func readMemoryBytes<T>(_ instance: T?) -> Data? {
        guard let noneOptionalInstance = instance else {
            return nil
        }
        return self.readStructMemoryBytes(noneOptionalInstance)
    }

    private static func readStructMemoryBytes<T>(_ instance: T) -> Data {
        return withUnsafeBytes(of: instance) { (rawBufferPointer) -> Data in
            return Data.init(rawBufferPointer)
        }
    }
}

extension MemoryBytesAide {
    public static func createInstanceFromMemoryBytes<T: AnyObject>(_ bytes: Data, type: T.Type) -> T? {
        let size: Int = class_getInstanceSize(type)
        guard bytes.count == size else {
            print("[ERROR]: Invalid memory bytes for \(type): bytes.count = \(bytes.count), \(type).size = \(size).")
            return nil
        }

        return bytes.withUnsafeBytes({ (rawBufferPointer) -> T? in
            let newPtr = UnsafeMutableRawBufferPointer.allocate(byteCount: rawBufferPointer.count, alignment: 1)
            newPtr.copyMemory(from: rawBufferPointer)

            let int32Ptr = newPtr.bindMemory(to: Int32.self)
            int32Ptr[3] = 0

            let unmanagedInstance = Unmanaged<T>.fromOpaque(newPtr.baseAddress!)
            let instance = unmanagedInstance.takeRetainedValue()

            return instance
        })
    }

    public static func readMemoryBytes<T: AnyObject>(_ instance: T) -> Data {
        return self.readClassMemoryBytes(instance)
    }

    public static func readMemoryBytes<T: AnyObject>(_ instance: T?) -> Data? {
        guard let noneOptionalInstance = instance else {
            return nil
        }
        return self.readClassMemoryBytes(noneOptionalInstance)
    }

    private static func readClassMemoryBytes<T: AnyObject>(_ instance: T) -> Data {
        let classType = type(of: instance)
        let instanceSize: Int = class_getInstanceSize(classType)
        let rawPointer = Unmanaged.passUnretained(instance).toOpaque()
        let rawBufferPointer = UnsafeRawBufferPointer.init(start: rawPointer, count: instanceSize)
        return Data.init(rawBufferPointer)
    }
}
