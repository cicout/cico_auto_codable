//
//  ViewController.swift
//  AutoCodableDemo
//
//  Created by lucky.li on 2018/6/5.
//  Copyright © 2018 cico. All rights reserved.
//

import UIKit
import AutoCodable

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func testBtnAction(_ sender: Any) {
        self.testCodableObject()
//        self.testCodableArray()
//        self.testCodableDictionary()
    }
    
    private func testCodableObject() {
        let jsonString = self.jsonString(name: "default")
        
        let object = TCodableClass.init(jsonString: jsonString, jsonDecoder: self.defaultJSONDecoder())
        if let object = object {
            print("\(object)")
        }
        
        let json = object?.toJSONString(jsonEncoder: self.defaultJSONEncoder())
        if let json = json {
            print("\(json)")
        }
        
        let object2 = TCodableStruct.init(jsonString: jsonString, jsonDecoder: self.defaultJSONDecoder())
        if let object2 = object2 {
            print("\(object2)")
        }
        
        let json2 = object2?.toJSONString(jsonEncoder: self.defaultJSONEncoder())
        if let json2 = json2 {
            print("\(json2)")
        }
    }
    
    private func testCodableArray() {
        let jsonString = self.jsonString(name: "default_array")
        
        let object = [TCodableClass].init(jsonString: jsonString, jsonDecoder: self.defaultJSONDecoder())
        if let object = object {
            print("\(object)")
        }
        
        let json = object?.toJSONString(jsonEncoder: self.defaultJSONEncoder())
        if let json = json {
            print("\(json)")
        }
        
        let object2 = [TCodableStruct].init(jsonString: jsonString, jsonDecoder: self.defaultJSONDecoder())
        if let object2 = object2 {
            print("\(object2)")
        }
        
        let json2 = object2?.toJSONString(jsonEncoder: self.defaultJSONEncoder())
        if let json2 = json2 {
            print("\(json2)")
        }
    }
    
    private func testCodableDictionary() {
        let jsonString = self.jsonString(name: "default_dictionary")
        
        let object = [String: TCodableClass].init(jsonString: jsonString, jsonDecoder: self.defaultJSONDecoder())
        if let object = object {
            print("\(object)")
        }
        
        let json = object?.toJSONString(jsonEncoder: self.defaultJSONEncoder())
        if let json = json {
            print("\(json)")
        }
        
        let object2 = [String: TCodableStruct].init(jsonString: jsonString, jsonDecoder: self.defaultJSONDecoder())
        if let object2 = object2 {
            print("\(object2)")
        }
        
        let json2 = object2?.toJSONString(jsonEncoder: self.defaultJSONEncoder())
        if let json2 = json2 {
            print("\(json2)")
        }
    }
    
    private func jsonString(name: String) -> String {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            return ""
        }
        
        guard let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) else {
            return ""
        }
        
        return jsonString
    }
    
    private func defaultJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }
    
    private func defaultJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        return encoder
    }
}

