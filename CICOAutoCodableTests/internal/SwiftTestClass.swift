//
//  TOCClass.swift
//  CICOAutoCodableTests
//
//  Created by lucky.li on 2018/8/16.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation
import CICOAutoCodable

class SwiftTestClass: CICOAutoCodable {
    var objectValue: OCCodingObjectWrapper<OCTestClass>?
    var enumValue: OCEnumWrapper<OCTestIntEnum>?
}
