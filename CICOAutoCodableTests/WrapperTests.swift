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

extension OCTestClass: NSCodingSerializable {}
extension OCTestClassX: NSCodingSerializable {}

class WrapperTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

//    func test_Enum_Wrapper() {
//        let enumValue = OCTestIntEnum.two
//        let enumValueWrapper = OCEnumWrapper<OCTestIntEnum>.init(value: enumValue)
//
//        let enumValueJSONString = enumValueWrapper.toJSONString()
//        XCTAssertNotNil(enumValueJSONString, "model to json failed")
//
//        let enumValueWrapperZ = OCEnumWrapper<OCTestIntEnum>.init(jsonString: enumValueJSONString!)
//        XCTAssertNotNil(enumValueWrapperZ, "json to model failed")
//        XCTAssert(enumValueWrapperZ!.value == enumValue, "invalid point")
//
//        let enumValueX = OCTestIntEnumX.onex
//        let enumValueWrapperX = OCEnumWrapper<OCTestIntEnumX>.init(value: enumValueX)
//
//        let enumValueJSONStringX = enumValueWrapperX.toJSONString()
//        XCTAssertNotNil(enumValueJSONStringX, "model to json failed")
//
//        let enumValueWrapperZX = OCEnumWrapper<OCTestIntEnumX>.init(jsonString: enumValueJSONStringX!)
//        XCTAssertNotNil(enumValueWrapperZX, "json to model failed")
//        XCTAssert(enumValueWrapperZX!.value == enumValueX, "invalid point")
//
//        // wrong data test (Enum should failed but it return one invalid enum!!!)
//        let wrongEnumValueWrapperZX = OCEnumWrapper<OCTestIntEnumX>.init(jsonString: enumValueJSONString!)
//        XCTAssertNil(wrongEnumValueWrapperZX, "json to model should failed with wrong json")
//        let wrongEnumValue = wrongEnumValueWrapperZX!.value
//        print("[*]: \(wrongEnumValueWrapperZX!), \(wrongEnumValue), \(wrongEnumValue.rawValue)")
//        XCTAssert(enumValueWrapperZXZ!.value == enumValueX, "invalid point")
//    }

    func test_Serializable_Wrapper() {
        let objectValue = OCTestClass.init()
        objectValue.text = "test_text"
        let objectValueWrapper = SerializableWrapper.init(value: objectValue)

        let objectValueJSONString = objectValueWrapper.toJSONString()
        XCTAssertNotNil(objectValueJSONString, "model to json failed")

        let objectValueWrapperZ = SerializableWrapper<OCTestClass>.init(jsonString: objectValueJSONString!)
        XCTAssertNotNil(objectValueWrapperZ, "json to model failed")
        XCTAssert(objectValueWrapperZ!.value.text == objectValue.text, "invalid point")

        // wrong data test
        let wrongObjectValueWrapperZ = SerializableWrapper<OCTestClassX>.init(jsonString: objectValueJSONString!)
        XCTAssertNil(wrongObjectValueWrapperZ, "json to model should failed with wrong json")
    }

    func test_Empty_Array_Serializable_Wrapper() {
        let emptyArray = [OCTestClass].init()

        let wrapper = SerializableWrapper.init(value: emptyArray)
        let jsonString = wrapper.toJSONString()
        XCTAssertNotNil(jsonString, "model to json failed")

        let wrapperx = SerializableWrapper<[OCTestClass]>.init(jsonString: jsonString!)
        XCTAssertNotNil(wrapperx, "json to model failed")
        XCTAssert(wrapperx!.value.count == 0, "Invalid value.")
    }

    func test_Array_Serializable_Wrapper() {
        var array = [OCTestClass].init()

        let objectValue = OCTestClass.init()
        objectValue.text = "test_text"
        array.append(objectValue)

        let wrapper = SerializableWrapper.init(value: array)
        let jsonString = wrapper.toJSONString()
        XCTAssertNotNil(jsonString, "model to json failed")

        let wrapperx = SerializableWrapper<[OCTestClass]>.init(jsonString: jsonString!)
        XCTAssertNotNil(wrapperx, "json to model failed")

        let objectValueX = wrapperx!.value.first
        XCTAssertNotNil(objectValueX, "invalid array value")

        XCTAssert(objectValueX!.text == objectValue.text, "invalid object value")

        // wrong data test
        let wrongwrapperx = SerializableWrapper<[OCTestClassX]>.init(jsonString: jsonString!)
        XCTAssertNil(wrongwrapperx, "json to model should failed with wrong json")
    }

    func test_Memory_Bytes_Wrapper() {
        let point = CGPoint.init(x: 1, y: 2)
        let pointWrapper = StructMemoryBytesWrapper.init(value: point)

        let pointJSONString = pointWrapper.toJSONString()
        XCTAssertNotNil(pointJSONString, "model to json failed")

        let pointWrapperX = StructMemoryBytesWrapper<CGPoint>.init(jsonString: pointJSONString!)
        XCTAssertNotNil(pointWrapperX, "json to model failed")
        XCTAssert(pointWrapperX!.value == point, "invalid point")

        let rect = CGRect.init(x: 1, y: 2, width: 3, height: 4)
        let rectWrapper = StructMemoryBytesWrapper<CGRect>.init(value: rect)

        let rectJSONString = rectWrapper.toJSONString()
        XCTAssertNotNil(rectJSONString, "model to json failed")

        let rectWrapperX = StructMemoryBytesWrapper<CGRect>.init(jsonString: rectJSONString!)
        XCTAssertNotNil(rectWrapperX, "json to model failed")
        XCTAssert(rectWrapperX!.value == rect, "invalid rect")

        let csValue = TCStruct.init()
        let csWrapper = StructMemoryBytesWrapper<TCStruct>.init(value: csValue)

        let csJSONString = csWrapper.toJSONString()
        XCTAssertNotNil(csJSONString, "model to json failed")

        let csWrapperX = StructMemoryBytesWrapper<TCStruct>.init(jsonString: csJSONString!)
        XCTAssertNotNil(csWrapperX, "json to model failed")
        XCTAssert(csWrapperX!.value.int1 == csValue.int1 &&
            csWrapperX!.value.int2 == csValue.int2 &&
            csWrapperX!.value.int3 == csValue.int3 &&
            csWrapperX!.value.int4 == csValue.int4 &&
            csWrapperX!.value.int5 == csValue.int5 &&
            csWrapperX!.value.int6 == csValue.int6, "invalid cs")

        let orientation = GLKQuaternionMake(1, 2, 3, 4)
        let orientationWrapper = StructMemoryBytesWrapper<GLKQuaternion>.init(value: orientation)

        let orientationJSONString = orientationWrapper.toJSONString()
        XCTAssertNotNil(orientationJSONString, "model to json failed")

        let orientationWrapperX = StructMemoryBytesWrapper<GLKQuaternion>.init(jsonString: orientationJSONString!)
        XCTAssertNotNil(orientationWrapperX, "json to model failed")
        XCTAssert(orientationWrapperX!.value.x == orientation.x &&
            orientationWrapperX!.value.y == orientation.y &&
            orientationWrapperX!.value.z == orientation.z &&
            orientationWrapperX!.value.w == orientation.w, "invalid orientation")

        // wrong data test
        let wrongRectWrapperY = StructMemoryBytesWrapper<CGRect>.init(jsonString: pointJSONString!)
        XCTAssertNil(wrongRectWrapperY, "json to model should failed with wrong json")
    }

    func test_Memory_Bytes_Wrapper_More() {
        let one = TStructOne.init()
        self.commonTest(one)

        let two = TStructTwo.init()
        self.commonTest(two)

//        let base = TClassBase.init()
//        self.commonTest(base)
//
//        let child = TClassChild.init()
//        self.commonTest(child)
    }

    private func commonStructTest<T: Equatable>(_ instance: T) {
        let instanceWrapper = StructMemoryBytesWrapper.init(value: instance)

        let instanceJSONString = instanceWrapper.toJSONString()
        XCTAssertNotNil(instanceJSONString, "model to json failed")

        let instanceWrapperX = StructMemoryBytesWrapper<T>.init(jsonString: instanceJSONString!)
        XCTAssertNotNil(instanceWrapperX, "json to model failed")
        XCTAssert(instanceWrapperX!.value == instance, "invalid point")
    }

    private func commonTest<T: Equatable>(_ instance: T) {
        self.commonStructTest(instance)
    }

    private func commonTest<T: Equatable>(_ instance: T?) {
        guard let tmpInstance = instance else {
            return
        }
        self.commonStructTest(tmpInstance)
    }

//    private func commonClassTest<T: Equatable & AnyObject>(_ instance: T) {
//        print("[#]: instance: \(instance)")
//
//        let instanceWrapper = ClassMemoryBytesWrapper.init(value: instance)
//
//        let instanceJSONString = instanceWrapper.toJSONString()
//        XCTAssertNotNil(instanceJSONString, "model to json failed")
//
//        print("[#]: instanceJSONString: \(instanceJSONString!)")
//
//        let instanceWrapperX = ClassMemoryBytesWrapper<T>.init(jsonString: instanceJSONString!)
//        XCTAssertNotNil(instanceWrapperX, "json to model failed")
//
//        print("[#]: New instance: \(instanceWrapperX!.value)")
//
//        XCTAssert(instanceWrapperX!.value == instance, "invalid point")
//    }

//    private func commonTest<T: Equatable & AnyObject>(_ instance: T) {
//        self.commonClassTest(instance)
//    }
//
//    private func commonTest<T: Equatable & AnyObject>(_ instance: T?) {
//        guard let tmpInstance = instance else {
//            return
//        }
//        self.commonClassTest(tmpInstance)
//    }
}
