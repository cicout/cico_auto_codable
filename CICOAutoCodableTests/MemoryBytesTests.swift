//
//  MemoryBytesTests.swift
//  CICOAutoCodableTests
//
//  Created by lucky.li on 2019/10/15.
//  Copyright © 2019 cico. All rights reserved.
//

import XCTest
import CICOAutoCodable

class MemoryBytesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInstance() {
        let one = TStructOne.init()
        self.commonTest(one)

        let two = TStructTwo.init()
        self.commonTest(two)

        let base = TClassBase.init()
        self.commonTest(base)

        let child = TClassChild.init()
        self.commonTest(child)
    }

    func testCreateInstance() {
        let data = Data.init()

        let structInstance = MemoryBytesAide.createInstanceFromMemoryBytes(data, type: TStructOne.self)
        XCTAssertNil(structInstance, "It should be nil when created from invalid data.")

        let classInstance = MemoryBytesAide.createInstanceFromMemoryBytes(data, type: TClassBase.self)
        XCTAssertNil(classInstance, "It should be nil when created from invalid data.")
    }

    func testRetainCount() {
        let instance = TClassChild.init()
        print("[#]: Retain count of TClassChild: \(CFGetRetainCount(instance))")

        self.retainCountCommonTest(instance)

        var array1 = [TClassChild].init()
        array1.append(instance)

        print("[#]: Retain count of TClassChild: \(CFGetRetainCount(instance))")

        self.retainCountCommonTest(instance)

        var array2 = [TClassChild].init()
        array2.append(instance)

        print("[#]: Retain count of TClassChild: \(CFGetRetainCount(instance))")

        self.retainCountCommonTest(instance)
    }

    func testOptional() {
        let two: TStructTwo? = TStructTwo.init()
        self.commonTest(two)

        let child: TClassChild? = TClassChild.init()
        self.commonTest(child)
    }

    func testBaseType() {
        let intValue: Int = 9
        self.commonTest(intValue)

        let doubleValue: Double = 8.8
        self.commonTest(doubleValue)

        let boolValue: Bool = true
        self.commonTest(boolValue)

        let enumValue: MyEnum = .two
        self.commonTest(enumValue)
    }

    private func commonStructTest<T: Equatable>(_ instance: T) {
        let data = MemoryBytesAide.readMemoryBytes(instance)
        print("[#]: MemoryBytes of \(instance):\n\(data as NSData)")

        let instancex = MemoryBytesAide.createInstanceFromMemoryBytes(data, type: T.self)
        XCTAssertNotNil(instancex, "Invalid instance from memory bytes.")

        print("[#]: New instance: \(instancex!)")

        XCTAssert(instancex! == instance, "Invalid instance from memory bytes.")
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

    private func commonClassTest<T: Equatable & AnyObject>(_ instance: T) {
        let data = MemoryBytesAide.readMemoryBytes(instance)
        print("[#]: MemoryBytes of \(instance):\n\(data as NSData)")

        let instancex = MemoryBytesAide.createInstanceFromMemoryBytes(data, type: T.self)
        XCTAssertNotNil(instancex, "Invalid instance from memory bytes.")

        print("[#]: New instance: \(instancex!)")

        XCTAssert(instancex! == instance, "Invalid instance from memory bytes.")
        XCTAssertFalse(instancex! === instance, "It should not be the same pointer address.")
    }

    private func commonTest<T: Equatable & AnyObject>(_ instance: T) {
        self.commonClassTest(instance)
    }

    private func commonTest<T: Equatable & AnyObject>(_ instance: T?) {
        guard let tmpInstance = instance else {
            return
        }
        self.commonClassTest(tmpInstance)
    }

    private func retainCountCommonTest<T: Equatable & AnyObject>(_ instance: T) {
        print("[#]: Retain count of instance: \(CFGetRetainCount(instance))")

        let data = MemoryBytesAide.readMemoryBytes(instance)
        print("[#]: MemoryBytes of \(instance):\n\(data as NSData)")

        let instancex = MemoryBytesAide.createInstanceFromMemoryBytes(data, type: T.self)
        XCTAssertNotNil(instancex, "Invalid instance from memory bytes.")
        print("[#]: New instance: \(instancex!)")
        print("[#]: Retain count of instancex: \(CFGetRetainCount(instancex!))")

        XCTAssert(instancex! == instance, "Invalid instance from memory bytes.")
        XCTAssertFalse(instancex! === instance, "It should not be the same pointer address.")

        let datax = MemoryBytesAide.readMemoryBytes(instancex!)
        print("[#]: MemoryBytes of \(instancex!):\n\(datax as NSData)")
    }
}
