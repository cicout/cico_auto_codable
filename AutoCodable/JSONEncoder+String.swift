//
//  JSONEncoder+String.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/6/5.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

public extension JSONEncoder {
    public func encodeToData<T: Encodable>(object: T) -> Data? {
        do {
            let data = try self.encode(object)
            return data
        } catch let error {
            print("[JSON_ENCODE_ERROR]: \(error)")
            return nil
        }
    }
    
    public func encodeToString<T: Encodable>(object: T) -> String? {
        guard let jsonData = self.encodeToData(object: object) else {
            return nil
        }
        
        let jsonString = String.init(data: jsonData, encoding: .utf8)
        return jsonString
    }
}
