//
//  PickerDelegate.swift
//  SwiftPicker
//
//  Created by Watthanai Chotcheewasunthorn on 4/11/2562 BE.
//  Copyright © 2562 CocoaPods. All rights reserved.
//

import Foundation

protocol SwiftPickerDelegate {
    func onDone(name: String?, results: [PickerResult])
    func onChange(name: String?, result: PickerResult)
}
