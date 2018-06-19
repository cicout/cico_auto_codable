//
//  JSONDecoder+String.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/6/5.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

public extension JSONDecoder {
    public func decodeJSONData<T: Decodable>(_ type: T.Type, from jsonData: Data) -> T? {
        do {
            let object = try self.decode(type, from: jsonData)
            return object
        } catch let error {
            print("[JSON_DECODE_ERROR]: \(error)")
            return nil
        }
    }
    
    public func decodeJSONString<T: Decodable>(_ type: T.Type, from jsonString: String) -> T? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        
        let object = self.decodeJSONData(T.self, from: jsonData)
        return object
    }
    
    public func decodeJSONObject<T: Decodable>(_ type: T.Type, from jsonObject: Any) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            let object = self.decodeJSONData(T.self, from: jsonData)
            return object
        } catch let error {
            print("[JSON_SERIALIZATION_ERROR]: \(error)")
            return nil
        }
    }
}
