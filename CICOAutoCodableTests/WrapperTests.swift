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
    
}
