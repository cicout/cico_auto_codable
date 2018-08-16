# CICOAutoCodable

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

CICOAutoCodable is an extension for codable, a new feature in Swift 4. It is very simple to achieve mutual conversion between model and JSON. And it provides automatic code completion using sourcery.

## Installation

You can simply add CICOAutoCodable to your `Cartfile`:  
```
github "cicout/cico_auto_codable"
```

## Sample Code
### Model And JSON Definition
```swift
enum MyEnum: String, CICOAutoCodable {
    case one
    case two
}

class MyClass: CICOAutoCodable {
    private(set) var stringValue: String?
    private(set) var dateValue: Date?
    private(set) var intValue: Int = 0
    private(set) var doubleValue: Double = 1.0
    private(set) var boolValue: Bool = false
    private(set) var enumValue: MyEnum = .one
    private(set) var urlValue: URL?
    private(set) var nextValue: MyClass?
    private(set) var arrayValue: [String]?
    private(set) var dicValue: [String: String]?
}
```
```json
{
    "stringValue": "string",
    "dateValue": 1234567890123,
    "intValue": 123,
    "doubleValue": 2.5,
    "boolValue": true,
    "enumValue": "two",
    "urlValue": "https://www.google.com",
    "nextValue": {
        "stringValue": "string",
        "intValue": 123,
        "doubleValue": 2.5,
        "boolValue": true,
        "enumValue": "two"
    },
    "arrayValue": [
              "string0",
              "string1",
              ],
    "dicValue": {
        "key0": "value0",
        "key1": "value1"
    }
}
```

### JSON TO Model
* Default JSONDecoder  
```swift
let object = MyClass.init(jsonString: myJSONString)
```

* Custom JSONDecoder  
```swift
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .millisecondsSince1970
let object = MyClass.init(jsonString: myJSONString, jsonDecoder: decoder)
```

### Model TO JSON
* Default JSONEncoder  
```swift
let jsonString = object?.toJSONString()
```
* Custom JSONEncoder  
```swift
let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .millisecondsSince1970
let jsonString = object?.toJSONString(jsonEncoder: encoder)
```
  
  
## OBJ-C Wrapper
* **OCCodingObjectWrapper**  
OCCodingObjectWrapper can make NSCoding Class in OBJ-C conform to Codable protocol in Swift.
```objc
@interface OCTestClass : NSObject <NSCoding>

@property (nonatomic, strong) NSString *text;

@end

@implementation OCTestClass

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.text = [coder decodeObjectForKey:@"text"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.text forKey:@"text"];
}

@end
``` 
```swift
class SwiftTestClass: CICOAutoCodable {
    var objectValue: OCCodingObjectWrapper<OCTestClass>?
}
``` 

* **OCEnumWrapper**  
OCEnumWrapper can make integer enum in OBJ-C conform to Codable protocol in Swift.
```objc
NS_ENUM(NSInteger, OCTestIntEnum) {
    one = 1,
    two
};
``` 
```swift
class SwiftTestClass: CICOAutoCodable {
    var enumValue: OCEnumWrapper<OCTestIntEnum>?
}
```
  
  
## Auto Code Completion
You don't need to write any mapping code when there is no custom mapping relationship using codable. However, you need to manually define the CodingKeys enumeration and list all the mappings, including the part that does not require a custom mapping, when there is any custom mapping relationship. CICOAutoCodable can complete the code for you automaticaly using sourcery.

### About Sourcery
* [Sourcery](https://github.com/krzysztofzablocki/Sourcery)  
* [Sourcery Reference](https://cdn.rawgit.com/krzysztofzablocki/Sourcery/master/docs/index.html)

### Install Sourcery
1. Copy "sourcery" directory in this framework source into your project;
2. Get the latest sourcery by CocoaPod; (replace `{YourProjectDir}` with your real project directory)  
```
cd "{YourProjectDir}"/sourcery/source
pod update
```
3. Open "yourProjectTarget" -> "Build Phases" -> "+" -> "New Run Script Phase", and add new run script below: (replace `{YourProjectName}` with your real project name)   
```
if [ "${CONFIGURATION}" = "Debug" ]; then
echo "[***** Start Running CICOAutoCodable Script *****]"
./sourcery/source/Pods/Sourcery/bin/sourcery --sources ./Carthage/Checkouts/cico_auto_codable/CICOAutoCodable --sources ./"{YourProjectName}" --templates ./Carthage/Checkouts/cico_auto_codable/sourcery/templates/ --output ./sourcery/auto_generated
echo "[***** End Running CICOAutoCodable Script *****]"
fi
```
4. Define your model and run;

### Sample Code
#### Model Definition
```swift
enum MyEnum: String, CICOAutoCodable {
    case one
    case two
}

class MyClass: CICOAutoCodable {
    private(set) var stringValue: String?
    private(set) var dateValue: Date?
    private(set) var intValue: Int = 0
    private(set) var doubleValue: Double = 1.0
    private(set) var boolValue: Bool = false
    private(set) var enumValue: MyEnum = .one
    private(set) var urlValue: URL?
    private(set) var next: MyClass?
    private(set) var arrayValue: [String]?
    private(set) var dicValue: [String: String]?
    private(set) var ignoredValue: String?
}
```

#### Using Custom And Ignored CodingKeys  
* CodingKeys Definition  
```swift
extension MyClass {
    enum CICOCustomCodingKeys: String {
        case next = "nextValue"
    }
    
    enum CICOIgnoredCodingKeys: String {
        case ignoredValue
    }
}
```
* Auto Generated Code  
```swift
// sourcery:inline:auto:MyClass.CICOAutoCodable_Auto_Generated_CodingKeys_Head
    enum CodingKeys: String, CodingKey {
// sourcery:inline:auto:MyClass.CodingKeys.CICOAutoCodable_Auto_Generated_Custom_CodingKeys
        case next = "nextValue"
// sourcery:inline:auto:MyClass.CodingKeys.CICOAutoCodable_Auto_Generated_CodingKeys
        case stringValue
        case dateValue
        case intValue
        case doubleValue
        case boolValue
        case enumValue
        case urlValue
        case arrayValue
        case dicValue
// sourcery:inline:auto:MyClass..CICOAutoCodable_Auto_Generated_CodingKeys_Tail
    }
// sourcery:end
```

#### Using CodingKeys Directly  
* CodingKeys Definition  
```swift
extension MyClass {
    enum CICOIgnoredCodingKeys: String {
        case ignoredValue
    }
    
    enum CodingKeys: String, CodingKey {
        case next = "nextValue"
    }
}
```
* Auto Generated Code  
```swift
extension MyClass {
    enum CICOIgnoredCodingKeys: String {
        case ignoredValue
    }
    
    enum CodingKeys: String, CodingKey {
        case next = "nextValue"

// sourcery:inline:auto:MyClass.CodingKeys.CICOAutoCodable_Auto_Generated_CodingKeys
        case stringValue
        case dateValue
        case intValue
        case doubleValue
        case boolValue
        case enumValue
        case urlValue
        case arrayValue
        case dicValue
// sourcery:end
    }
}
```

## Requirements
* iOS 8.0+
* Swift 4.0+

## License
CICOAutoCodable is released under the MIT license. See [LICENSE](https://github.com/cicout/cico_auto_codable/blob/master/LICENSE) for details.

## More
Have a question? Please open an [issue](https://github.com/cicout/cico_auto_codable/issues/new)!
