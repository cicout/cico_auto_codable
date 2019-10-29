//
//  TOCClass.swift
//  CICOAutoCodableTests
//
//  Created by lucky.li on 2018/8/16.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation
import CICOAutoCodable

extension OCTestIntEnum: Codable {}
extension OCTestIntEnumX: Codable {}

class SwiftTestClass: CICOAutoCodable {
    var objectValue: SerializableWrapper<OCTestClass>?
    var enumValue: OCEnumWrapper<OCTestIntEnum>?
    var enumValueX: OCTestIntEnum?
}
