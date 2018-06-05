//
//  JSONDecoder+String.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/6/5.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

public extension JSONDecoder {
    public func decodeData<T: Decodable>(_ type: T.Type, from jsonData: Data) -> T? {
        do {
            let object = try self.decode(type, from: jsonData)
            return object
        } catch let error {
            print("[JSON_DECODE_ERROR]: \(error)")
            return nil
        }
    }
    
    public func decodeString<T: Decodable>(_ type: T.Type, from jsonString: String) -> T? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        
        let object = self.decodeData(T.self, from: jsonData)
        return object
    }
}
