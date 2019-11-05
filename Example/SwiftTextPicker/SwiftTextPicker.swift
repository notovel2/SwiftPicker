//
//  SwiftTextPicker.swift
//  SwiftPicker
//
//  Created by Watthanai Chotcheewasunthorn on 4/11/2562 BE.
//  Copyright © 2562 CocoaPods. All rights reserved.
//

import UIKit

open class SwiftTextPicker: UIButton, UIPickerViewDelegate {
    private var view: UIView?
    private var pickerView: UIPickerView?
    private var pickerTextField: UITextField?
    private var toolBar: UIToolbar?
    
    private var id: String?
    private var isShowToolbar: Bool = true
//    var selectedIndex: Int = 0
    var pickerSections: [PickerSection] = []
    var parentViewController: UIViewController?
    var pickerBackgroundColor: UIColor = .white {
        didSet {
            self.backgroundColor = self.pickerBackgroundColor
        }
    }
    
    var pickerBorderColor: UIColor = UIColor(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1) {
        didSet {
            self.layer.borderColor = self.pickerBorderColor.cgColor
        }
    }
    
    var delegate: SwiftPickerDelegate?
    
    //MARK: - Actions
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pickerTextField?.becomeFirstResponder()
    }
    
    private var title: String {
        return self.pickerSections.enumerated().map{ (component, item) -> String in
            guard let index = self.pickerView?.selectedRow(inComponent: component) else {
                return ""
            }
            return item.titlelist[index]
        }.joined(separator: " ")
    }
    
    init(in view: UIView,
         parentViewController: UIViewController,
         pickerSections: [PickerSection],
         id: String,
         isShowToolbar: Bool = true) {
        super.init(frame: view.frame)
        self.id = id
        self.isShowToolbar = isShowToolbar
        self.pickerSections.append(contentsOf: pickerSections)
        self.view = view
        self.parentViewController = parentViewController
        initComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initComponents()
    }
    
    deinit {
        pickerView?.removeFromSuperview()
        toolBar?.removeFromSuperview()
        pickerTextField?.removeFromSuperview()
    }
    
    private func initComponents() {
        pickerView = getPickerView()
        toolBar = isShowToolbar ? getToolbar() : nil
        if let picker = pickerView {
            pickerTextField = getTextField(with: picker,
                                           and: toolBar)
        }
        self.setTitle(title, for: .normal)
        setupLayout()
        add(self, to: view)
    }
    
    private func add(_ picker: UIButton, to view: UIView?) {
        view?.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints  = false
        let topConstraint = NSLayoutConstraint(item: picker, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: picker, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: picker, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: picker, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        view?.addConstraints([topConstraint,
                              bottomConstraint,
                              leadingConstraint,
                              trailingConstraint])
    }
    
    //MARK: - Fucntions
    private func setupLayout() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius =  5.0
        let borderColor = self.pickerBorderColor
        self.layer.borderColor = borderColor.cgColor
        let image = UIImage(named: "ic_chevron_down")
        self.setImage(image, for: .normal)
        self.titleLabel?.font = UIFont(name: "Prompt", size: 17)
        self.setTitleColor(.black, for: .normal)
    }
    
    private func getPickerView() -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = pickerBackgroundColor
        return picker
    }
    
    private func getTextField(with picker: UIPickerView, and toolbar: UIToolbar?) -> UITextField {
        let textfield = UITextField()
        textfield.isHidden = true
        textfield.inputView = picker
        if let aToolbar = toolbar {
            textfield.inputAccessoryView = aToolbar
        }
        self.parentViewController?.view?.addSubview(textfield)
        return textfield
    }
    
    private func getToolbar() -> UIToolbar {

        let toolbar = UIToolbar(frame: CGRect(x: 0,
                                              y: (self.parentViewController?.view.frame.size.height ?? 0)/6,
                                              width: self.parentViewController?.view.frame.size.width ?? 100,
                                              height: 40.0))
        toolbar.layer.position = CGPoint(x: (self.parentViewController?.view.frame.size.width ?? 100)/2,
                                         y: (self.parentViewController?.view.frame.size.height ?? 80)-20.0)
        toolbar.items = [
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDone))
        ]
        return toolbar
    }
    
    @objc func onDone() {
//        guard let index = self.pickerView?.selectedRow(inComponent: 0) else {
//            return
//        }
        self.pickerTextField?.resignFirstResponder()
        let result: [PickerResult] = pickerSections.enumerated().map { (component, items) -> PickerResult in
            guard let index = pickerView?.selectedRow(inComponent: component),
                items.titlelist.count > index else {
                return PickerResult(component: component, title: items.titlelist.first ?? "", row: 0)
            }
            return PickerResult(component: component, title: items.titlelist[index], row: index)
        }
        self.setTitle(title, for: .normal)
//        selectedIndex = index
        
        delegate?.onDone(name: id, results: result)
    }
}

//MARK: - UIPickerViewDataSource
extension SwiftTextPicker: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerSections.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (component < pickerSections.count) ? pickerSections[component].titlelist.count : 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerSections[component].titlelist[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if !isShowToolbar {
            self.setTitle(title, for: .normal)
        }
        let result = PickerResult(component: component,
                                  title: pickerSections[component].titlelist[row],
                                  row: row)
        delegate?.onChange(name: id, result: result)
    }
}
