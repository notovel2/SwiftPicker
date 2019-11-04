# SwiftPicker

[![CI Status](https://img.shields.io/travis/notovel2/SwiftPicker.svg?style=flat)](https://travis-ci.org/notovel2/SwiftPicker)
[![Version](https://img.shields.io/cocoapods/v/SwiftPicker.svg?style=flat)](https://cocoapods.org/pods/SwiftPicker)
[![License](https://img.shields.io/cocoapods/l/SwiftPicker.svg?style=flat)](https://cocoapods.org/pods/SwiftPicker)
[![Platform](https://img.shields.io/cocoapods/p/SwiftPicker.svg?style=flat)](https://cocoapods.org/pods/SwiftPicker)

## Requirements
Swift 5.1+

## Installation

SwiftPicker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftPicker'
```

## Usage

Picker for a text
```swift
import SwiftPicker
class ViewController: UIViewController {
    @IBOutlet weak var pickerContainer: UIView!
    private var pickerView: SwiftTextPicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView = SwiftTextPicker(in: pickerContainer, parentViewController: self, pickerSections: [], id: "1")
        pickerView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: SwiftPickerDelegate {
    func onDone(name: String?, results: [PickerResult]) {
        // code when press Done Button
    }
    
    func onChange(name: String?, result: PickerResult) {
        //code when select item in picker
    }
}
```

## Author

notovel2, notovel2@gmail.com

## License

SwiftPicker is available under the MIT license. See the LICENSE file for more info.
