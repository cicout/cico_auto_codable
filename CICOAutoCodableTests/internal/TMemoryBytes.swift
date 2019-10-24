//
//  TMemoryBytes.swift
//  CICOAutoCodableTests
//
//  Created by lucky.li on 2019/10/15.
//  Copyright © 2019 cico. All rights reserved.
//

import Foundation
import CICOAutoCodable

public struct TStructOne: AutoEquatable {
    var intValue: Int = 3
    var doubleValue: Double = 2.5
    var boolValue: Bool = true
}

public struct TStructTwo: AutoEquatable {
    var intValue: Int = 3
    var doubleValue: Double = 2.5
    var boolValue: Bool = true
    var dateValue: Date = Date.init()
    var enumValue: MyEnum = .one
//    var stringValue: String = "test"
//    var urlValue: URL = URL.init(string: "https://www.apple.com")!

}

public class TClassBase: Equatable, CustomStringConvertible {
    var intValue: Int = 3
    var doubleValue: Double = 2.5
    var boolValue: Bool = true

    public static func == (lhs: TClassBase, rhs: TClassBase) -> Bool {
        guard lhs.intValue == rhs.intValue else { return false }
        guard lhs.doubleValue == rhs.doubleValue else { return false }
        guard lhs.boolValue == rhs.boolValue else { return false }
        return true
    }

    public var description: String {
        return "<\(type(of: self))>: \(self.intValue), \(self.doubleValue), \(self.boolValue)"
    }

    deinit {
        print("TClassBase: \(self) deinit")
    }
}

public class TClassChild: TClassBase {
    var enumValue: MyEnum = .one
    var dateValue: Date = Date.init()

    // String is collection of char, it contains pointer inside.
    // It will crash using memory bytes.
//    var stringValue: String = String.init(format: "test_int_%d", 7)

    public static func == (lhs: TClassChild, rhs: TClassChild) -> Bool {
        guard lhs.intValue == rhs.intValue else { return false }
        guard lhs.doubleValue == rhs.doubleValue else { return false }
        guard lhs.boolValue == rhs.boolValue else { return false }
        guard lhs.enumValue == rhs.enumValue else { return false }
        guard lhs.dateValue == rhs.dateValue else { return false }
        return true
    }

    public override var description: String {
        return "\(super.description)###<\(type(of: self))>: \(self.enumValue), \(self.dateValue)"
    }

    deinit {
        print("TClassChild: \(self) deinit")
    }
}
