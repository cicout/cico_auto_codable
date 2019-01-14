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
        let emptyArray = [OCTestClass].init()
        
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
    
    func test_C_Struct_Wrapper() {
        let point = CGPoint.init(x: 1, y: 2)
        let pointWrapper = CStructWrapper<CGPoint>.init(value: point)
        
        let pointJSONString = pointWrapper.toJSONString()
        XCTAssertNotNil(pointJSONString, "model to json failed")
        
        let pointWrapperX = CStructWrapper<CGPoint>.init(jsonString: pointJSONString!)
        XCTAssertNotNil(pointWrapperX, "json to model failed")
        XCTAssert(pointWrapperX!.value == point, "invalid point")
        
        let rect = CGRect.init(x: 1, y: 2, width: 3, height: 4)
        let rectWrapper = CStructWrapper<CGRect>.init(value: rect)
        
        let rectJSONString = rectWrapper.toJSONString()
        XCTAssertNotNil(rectJSONString, "model to json failed")
        
        let rectWrapperX = CStructWrapper<CGRect>.init(jsonString: rectJSONString!)
        XCTAssertNotNil(rectWrapperX, "json to model failed")
        XCTAssert(rectWrapperX!.value == rect, "invalid rect")
    }
}
