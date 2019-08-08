//
//  CICOAutoCodableTests.swift
//  CICOAutoCodableTests
//
//  Created by lucky.li on 2018/7/31.
//  Copyright © 2018 cico. All rights reserved.
//

import XCTest

class CICOAutoCodableTests: XCTestCase {
    private var defaultJSONString: String!
    private var defaultJSONArrayString: String!
    private var defaultJSONDicString: String!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        self.defaultJSONString = self.jsonString(name: "default")
        self.defaultJSONArrayString = self.jsonString(name: "default_array")
        self.defaultJSONDicString = self.jsonString(name: "default_dictionary")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()

        self.defaultJSONString = nil
        self.defaultJSONArrayString = nil
        self.defaultJSONDicString = nil
    }

    func test_JSONString() {
        XCTAssertNotNil(self.defaultJSONString, "invalid default json string")
        XCTAssertNotNil(self.defaultJSONArrayString, "invalid default json array string")
        XCTAssertNotNil(self.defaultJSONDicString, "invalid default json dic string")
    }

    func test_Class() {
        let object = TCodableClass.init(jsonString: self.defaultJSONString!)
        XCTAssertNotNil(object, "json to object failed")

        let jsonString = object?.toJSONString()
        XCTAssertNotNil(jsonString, "object to json failed")

        let objectX = TCodableClass.init(jsonString: jsonString!)
        XCTAssertNotNil(objectX, "json back to object failed")
        XCTAssert(objectX! == object!, "objectX != object")
    }

    func test_Struct() {
        let object = TCodableStruct.init(jsonString: self.defaultJSONString!)
        XCTAssertNotNil(object, "json to object failed")

        let jsonString = object?.toJSONString()
        XCTAssertNotNil(jsonString, "object to json failed")

        let objectX = TCodableStruct.init(jsonString: jsonString!)
        XCTAssertNotNil(objectX, "json back to object failed")
        XCTAssert(objectX! == object!, "objectX != object")
    }

    func test_Class_With_Custom_Decoder_And_Encoder() {
        let object = TCodableClass.init(jsonString: self.defaultJSONString!, jsonDecoder: self.customJSONDecoder())
        XCTAssertNotNil(object, "json to object failed")

        let jsonString = object?.toJSONString(jsonEncoder: self.customJSONEncoder())
        XCTAssertNotNil(jsonString, "object to json failed")

        let objectX = TCodableClass.init(jsonString: jsonString!, jsonDecoder: self.customJSONDecoder())
        XCTAssertNotNil(objectX, "json back to object failed")
        XCTAssert(objectX! == object!, "objectX != object")
    }

    func test_Class_Array() {
        let objectArray = [TCodableClass].init(jsonString: self.defaultJSONArrayString!)
        XCTAssertNotNil(objectArray, "json to object array failed")

        let jsonStringArray = objectArray?.toJSONString()
        XCTAssertNotNil(jsonStringArray, "object array to json failed")

        let objectArrayX = [TCodableClass].init(jsonString: jsonStringArray!)
        XCTAssertNotNil(objectArrayX, "json back to object array failed")

        for i in 0..<objectArray!.count {
            XCTAssert(objectArrayX![i] == objectArray![i], "objectArrayX[\(i)] != objectArray[\(i)]")
        }
    }

    func test_Class_Dic() {
        let objectDic = [String: TCodableClass].init(jsonString: self.defaultJSONDicString!)
        XCTAssertNotNil(objectDic, "json to object dic failed")

        let jsonStringDic = objectDic?.toJSONString()
        XCTAssertNotNil(jsonStringDic, "object dic to json failed")

        let objectDicX = [String: TCodableClass].init(jsonString: jsonStringDic!)
        XCTAssertNotNil(objectDicX, "json back to object dic failed")

        objectDic?.forEach({ (key, value) in
            let valueX = objectDicX![key]
            XCTAssertNotNil(valueX, "invalid objectDicX[\(key)]")
            XCTAssert(valueX! == value, "objectDicX[\(key)] != objectDicX[\(key)]")
        })
    }

    func test_Int() {
        let i = 5
        let jsonString = i.toJSONString()
        XCTAssertNil(jsonString, "int to json string should be nil")

        let t = "5"
        let object = Int.init(jsonString: t)
        XCTAssertNil(object, "string to int should be nil")
    }

    private func jsonString(name: String) -> String? {
        let bundle = Bundle.init(for: type(of: self))

        guard let path = bundle.path(forResource: name, ofType: "json") else {
            return nil
        }

        guard let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) else {
            return nil
        }

        return jsonString
    }

    private func customJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }

    private func customJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        return encoder
    }
}
