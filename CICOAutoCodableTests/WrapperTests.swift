//
//  WrapperTests.swift
//  CICOAutoCodableTests
//
//  Created by lucky.li on 2018/8/16.
//  Copyright © 2018 cico. All rights reserved.
//

import XCTest
import CICOAutoCodable

class WrapperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Wrapper() {
        let value = SwiftTestClass.init()
        
        let objectValue = OCTestClass.init()
        objectValue.text = "test_text"
        value.objectValue = OCCodingObjectWrapper<OCTestClass>.init(value: objectValue)
        
        let enumValue = OCTestIntEnum.two
        value.enumValue = OCEnumWrapper<OCTestIntEnum>.init(value: enumValue)
        
        XCTAssertNotNil(value, "invalid value")
        
        let jsonString = value.toJSONString()
        XCTAssertNotNil(jsonString, "model to json failed")
        
        let valuex = SwiftTestClass.init(jsonString: jsonString!)
        XCTAssertNotNil(valuex, "json to model failed")
        
        XCTAssert(valuex!.objectValue!.value.text == value.objectValue!.value.text, "object value unequal")
        XCTAssert(valuex!.enumValue!.value == value.enumValue!.value, "enum value unequal")
    }
    
    func test_Empty_Array_Wrapper() {
        var emptyArray = [OCTestClass].init()
        
        let wrapper = OCCodingObjectArrayWrapper<OCTestClass>.init(value: emptyArray)
        let jsonString = wrapper.toJSONString()
        XCTAssertNotNil(jsonString, "model to json failed")
        
        let wrapperx = OCCodingObjectArrayWrapper<OCTestClass>.init(jsonString: jsonString!)
        XCTAssertNotNil(wrapperx, "json to model failed")
    }
    
    func test_Array_Wrapper() {
        var array = [OCTestClass].init()
        
        let objectValue = OCTestClass.init()
        objectValue.text = "test_text"
        array.append(objectValue)
        
        let wrapper = OCCodingObjectArrayWrapper<OCTestClass>.init(value: array)
        let jsonString = wrapper.toJSONString()
        XCTAssertNotNil(jsonString, "model to json failed")
        
        let wrapperx = OCCodingObjectArrayWrapper<OCTestClass>.init(jsonString: jsonString!)
        XCTAssertNotNil(wrapperx, "json to model failed")
        
        let objectValueX = wrapperx!.value.first
        XCTAssertNotNil(objectValueX, "invalid array value")
        
        XCTAssert(objectValueX!.text == objectValue.text, "invalid object value")
    }
}
