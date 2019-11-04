//
//  ViewController.swift
//  SwiftPicker
//
//  Created by notovel2 on 11/04/2019.
//  Copyright (c) 2019 notovel2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pickerContainer: UIView!
    private var pickerView: SwiftTextPicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView = SwiftTextPicker(in: pickerContainer, parentViewController: self, pickerSections: [], id: "Hello")
        pickerView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: SwiftPickerDelegate {
    func onDone(name: String?, results: [PickerResult]) {
        print("Done")
    }
    
    func onChange(name: String?, result: PickerResult) {
        print("Change")
    }
    
    
}
