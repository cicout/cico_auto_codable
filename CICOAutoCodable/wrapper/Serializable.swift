//
//  Serializable.swift
//  CICOAutoCodable
//
//  Created by lucky.li on 2019/10/26.
//  Copyright © 2019 cico. All rights reserved.
//

import Foundation

public protocol Serializable {
    static func createFromSerializedData(_ data: Data) -> Self?
    func serializedData() -> Data?
}

public protocol NSCodingSerializable: Serializable {}

public extension NSCodingSerializable where Self: NSCoding, Self: NSObject {
    static func createFromSerializedData(_ data: Data) -> Self? {
        if #available(iOS 9.0, *) {
            do {
                guard let instance = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Self else {
                    print("[ERROR]: Unarchive failed for \(Self.self).")
                    return nil
                }
                return instance
            } catch {
                print("[ERROR]: Unarchive failed: error = \(error)")
                return nil
            }
        } else {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? Self
        }
    }

    func serializedData() -> Data? {
        if #available(iOS 11.0, *) {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
                return data
            } catch {
                print("[ERROR]: Archive failed: error = \(error)")
                return nil
            }
        } else {
            return NSKeyedArchiver.archivedData(withRootObject: self)
        }
    }
}

extension Array: Serializable where Element: NSCoding, Element: NSObject {
    public static func createFromSerializedData(_ data: Data) -> Self? {
        if #available(iOS 9.0, *) {
            do {
                guard let instance = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Self else {
                    print("[ERROR]: Unarchive failed for \(Self.self).")
                    return nil
                }
                return instance
            } catch {
                print("[ERROR]: Unarchive failed: error = \(error)")
                return nil
            }
        } else {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? Self
        }
    }

    public func serializedData() -> Data? {
        if #available(iOS 11.0, *) {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
                return data
            } catch {
                print("[ERROR]: Archive failed: error = \(error)")
                return nil
            }
        } else {
            return NSKeyedArchiver.archivedData(withRootObject: self)
        }
    }
}
