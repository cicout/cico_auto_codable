// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}


// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - TCodableClass AutoEquatable
extension TCodableClass: Equatable {}
internal func == (lhs: TCodableClass, rhs: TCodableClass) -> Bool {
    guard compareOptionals(lhs: lhs.name, rhs: rhs.name, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.stringValue, rhs: rhs.stringValue, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.dateValue, rhs: rhs.dateValue, compare: ==) else { return false }
    guard lhs.intValue == rhs.intValue else { return false }
    guard compareOptionals(lhs: lhs.doubleValue, rhs: rhs.doubleValue, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.boolValue, rhs: rhs.boolValue, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.next, rhs: rhs.next, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.arrayValue, rhs: rhs.arrayValue, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.dicValue, rhs: rhs.dicValue, compare: ==) else { return false }
    return true
}
// MARK: - TCodableStruct AutoEquatable
extension TCodableStruct: Equatable {}
internal func == (lhs: TCodableStruct, rhs: TCodableStruct) -> Bool {
    guard compareOptionals(lhs: lhs.name, rhs: rhs.name, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.stringValue, rhs: rhs.stringValue, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.dateValue, rhs: rhs.dateValue, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.intValue, rhs: rhs.intValue, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.doubleValue, rhs: rhs.doubleValue, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.boolValue, rhs: rhs.boolValue, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.next, rhs: rhs.next, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.arrayValue, rhs: rhs.arrayValue, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.dicValue, rhs: rhs.dicValue, compare: ==) else { return false }
    return true
}

// MARK: - AutoEquatable for Enums
