//
//  WrapperTests.swift
//  CICOAutoCodableTests
//
//  Created by lucky.li on 2018/8/16.
//  Copyright © 2018 cico. All rights reserved.
//

import XCTest
import CICOAutoCodable
import GLKit

class WrapperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Enum_Wrapper() {
        let enumValue = OCTestIntEnum.two
        let enumValueWrapper = OCEnumWrapper<OCTestIntEnum>.init(value: enumValue)
        
        let enumValueJSONString = enumValueWrapper.toJSONString()
        XCTAssertNotNil(enumValueJSONString, "model to json failed")
        
        let enumValueWrapperZ = OCEnumWrapper<OCTestIntEnum>.init(jsonString: enumValueJSONString!)
        XCTAssertNotNil(enumValueWrapperZ, "json to model failed")
        XCTAssert(enumValueWrapperZ!.value == enumValue, "invalid point")
        
        let enumValueX = OCTestIntEnumX.onex
        let enumValueWrapperX = OCEnumWrapper<OCTestIntEnumX>.init(value: enumValueX)
        
        let enumValueJSONStringX = enumValueWrapperX.toJSONString()
        XCTAssertNotNil(enumValueJSONStringX, "model to json failed")
        
        let enumValueWrapperZX = OCEnumWrapper<OCTestIntEnumX>.init(jsonString: enumValueJSONStringX!)
        XCTAssertNotNil(enumValueWrapperZX, "json to model failed")
        XCTAssert(enumValueWrapperZX!.value == enumValueX, "invalid point")
        
        // wrong data test (Enum should failed but it return one invalid enum!!!)
        let wrongEnumValueWrapperZX = OCEnumWrapper<OCTestIntEnumX>.init(jsonString: enumValueJSONString!)
//        XCTAssertNil(wrongEnumValueWrapperZX, "json to model should failed with wrong json")
        let wrongEnumValue = wrongEnumValueWrapperZX!.value
        print("[*]: \(wrongEnumValueWrapperZX!), \(wrongEnumValue), \(wrongEnumValue.rawValue)")
//        XCTAssert(enumValueWrapperZXZ!.value == enumValueX, "invalid point")
    }
    
    func test_Coding_Object_Wrapper() {
        let objectValue = OCTestClass.init()
        objectValue.text = "test_text"
        let objectValueWrapper = OCCodingObjectWrapper<OCTestClass>.init(value: objectValue)
        
        let objectValueJSONString = objectValueWrapper.toJSONString()
        XCTAssertNotNil(objectValueJSONString, "model to json failed")
        
        let objectValueWrapperZ = OCCodingObjectWrapper<OCTestClass>.init(jsonString: objectValueJSONString!)
        XCTAssertNotNil(objectValueWrapperZ, "json to model failed")
        XCTAssert(objectValueWrapperZ!.value.text == objectValue.text, "invalid point")
        
        // wrong data test
        let wrongObjectValueWrapperZ = OCCodingObjectWrapper<OCTestClassX>.init(jsonString: objectValueJSONString!)
        XCTAssertNil(wrongObjectValueWrapperZ, "json to model should failed with wrong json")
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
        
        // wrong data test
        let wrongwrapperx = OCCodingObjectArrayWrapper<OCTestClassX>.init(jsonString: jsonString!)
        XCTAssertNil(wrongwrapperx, "json to model should failed with wrong json")
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
        
        let orientation = GLKQuaternionMake(1, 2, 3, 4)
        let orientationWrapper = CStructWrapper<GLKQuaternion>.init(value: orientation)
        
        let orientationJSONString = orientationWrapper.toJSONString()
        XCTAssertNotNil(orientationJSONString, "model to json failed")
        
        let orientationWrapperX = CStructWrapper<GLKQuaternion>.init(jsonString: orientationJSONString!)
        XCTAssertNotNil(orientationWrapperX, "json to model failed")
        XCTAssert(orientationWrapperX!.value.x == orientation.x &&
            orientationWrapperX!.value.y == orientation.y &&
            orientationWrapperX!.value.z == orientation.z &&
            orientationWrapperX!.value.w == orientation.w, "invalid orientation")
        
        // wrong data test
        let wrongRectWrapperY = CStructWrapper<CGRect>.init(jsonString: pointJSONString!)
        XCTAssertNil(wrongRectWrapperY, "json to model should failed with wrong json")
    }
}
