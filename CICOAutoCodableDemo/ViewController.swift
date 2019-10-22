//
//  ViewController.swift
//  AutoCodableDemo
//
//  Created by lucky.li on 2018/6/5.
//  Copyright © 2018 cico. All rights reserved.
//

import UIKit
import CICOAutoCodable

class ViewController: UIViewController {
    var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func testBtnAction(_ sender: UIButton) {
//        self.testMyClass()
        self.testRetainCount()

        self.count += 1
        if self.count % 2 == 0 {
            sender.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        } else {
            sender.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        }
    }

    private func testMyClass() {
        let myJSONString = self.jsonString(name: "my")

        let object = MyClass.init(jsonString: myJSONString, jsonDecoder: self.defaultJSONDecoder())
        if let object = object {
            print("\(object)")
        }

        let jsonString = object?.toJSONString(jsonEncoder: self.defaultJSONEncoder())
        if let json = jsonString {
            print("\(json)")
        }
    }

    private func testRetainCount() {
        let instance = TClassChild.init()

        print("[#]: Retain count of instance: \(CFGetRetainCount(instance))")

        var array = [TClassChild].init()
        array.append(instance)

        print("[#]: Retain count of instance: \(CFGetRetainCount(instance))")

        let data = MemoryBytesAide.readMemoryBytes(instance)
        print("[#]: MemoryBytes of \(instance):\n\(data as NSData)")

        let instancex = MemoryBytesAide.createInstanceFromMemoryBytes(data, type: TClassChild.self)
        print("[#]: New instance: \(instancex!)")
        print("[#]: Retain count of instancex: \(CFGetRetainCount(instancex!))")

        let datax = MemoryBytesAide.readMemoryBytes(instancex!)
        print("[#]: MemoryBytes of \(instancex!):\n\(datax as NSData)")
    }

    private func jsonString(name: String) -> String {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            return ""
        }

        guard let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) else {
            return ""
        }

        return jsonString
    }

    private func defaultJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }

    private func defaultJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        return encoder
    }
}
