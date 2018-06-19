//
//  JSONEncoder+String.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/6/5.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

public extension JSONEncoder {
    public func encodeToJSONData<T: Encodable>(object: T) -> Data? {
        do {
            let data = try self.encode(object)
            return data
        } catch let error {
            print("[JSON_ENCODE_ERROR]: \(error)")
            return nil
        }
    }
    
    public func encodeToJSONString<T: Encodable>(object: T) -> String? {
        guard let jsonData = self.encodeToJSONData(object: object) else {
            return nil
        }
        
        let jsonString = String.init(data: jsonData, encoding: .utf8)
        return jsonString
    }
    
    public func encodeToJSONObject<T: Encodable, R>(object: T, returnType: R.Type) -> R? {
        guard let jsonData = self.encodeToJSONData(object: object) else {
            return nil
        }
        
        do {
            let object = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? R
            return object
        } catch let error {
            print("[JSON_SERIALIZATION_ERROR]: \(error)")
            return nil
        }
    }
    
    public func encodeToJSONDictionary<T: Encodable>(object: T) -> Dictionary<AnyHashable, Any>? {
        return self.encodeToJSONObject(object: object, returnType: Dictionary<AnyHashable, Any>.self)
    }
    
    public func encodeToJSONArray<T: Encodable>(object: [T]) -> Array<Any>? {
        return self.encodeToJSONObject(object: object, returnType: Array<Any>.self)
    }
}
