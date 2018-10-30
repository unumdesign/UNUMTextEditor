//
//  ViewController.swift
//  UNUMTextEditor
//
//  Created by zhaoli1211 on 10/29/2018.
//  Copyright (c) 2018 zhaoli1211. All rights reserved.
//

import UIKit
import UNUMTextEditor

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!

    @IBOutlet var container: UIView!

    @IBOutlet var containerHeight: NSLayoutConstraint!

    var textEditorViewController: UNUMTextEditorToolBarViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardToolBar(textView)
        textView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getToolBarHeight(toolbarType: UNUMTextEditorToolType) -> CGFloat {
        switch toolbarType {
        case .EditFont: return 181
        case .EditSize: return 144
        case .EditAlignment: return 163
        case .EditLetterSpacing: return 144
        case .EditLineSpacing: return 144
        case .EditColor: return 157
        case .Close: return 0
        }
    }

    //set tool bar above ket board
    func addKeyboardToolBar(_ textView: UITextView) {
        let bar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45))

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)

        let fontButton = UIBarButtonItem(image: UIImage(named: "font-icon-small"), style: .plain, target: self, action: #selector(editTextAction(_:)))
        fontButton.tag = 1
        fontButton.tintColor = .black
        let sizeButton = UIBarButtonItem(image: UIImage(named: "size-icon"), style: .plain, target: self, action: #selector(editTextAction(_:)))
        sizeButton.tag = 2
        sizeButton.tintColor = .black
        let alignmentButton = UIBarButtonItem(image: UIImage(named: "textAlignment"), style: .plain, target: self, action: #selector(editTextAction(_:)))
        alignmentButton.tag = 3
        alignmentButton.tintColor = .black
        let letterSpacingButton = UIBarButtonItem(image: UIImage(named: "letterSpacing"), style: .plain, target: self, action: #selector(editTextAction(_:)))
        letterSpacingButton.tag = 4
        letterSpacingButton.tintColor = .black
        let lineSpaceingButton = UIBarButtonItem(image: UIImage(named: "lineSpacing"), style: .plain, target: self, action: #selector(editTextAction(_:)))
        lineSpaceingButton.tag = 5
        lineSpaceingButton.tintColor = .black
        let colorButton = UIBarButtonItem(image: UIImage(named: "color"), style: .plain, target: self, action: #selector(editTextAction(_:)))
        colorButton.tag = 6
        colorButton.tintColor = .black
        bar.items = [fontButton, flexibleSpace, sizeButton, flexibleSpace, alignmentButton, flexibleSpace, letterSpacingButton, flexibleSpace, lineSpaceingButton, flexibleSpace, colorButton]
        textView.inputAccessoryView = bar
    }

    //add text edtior view
    @objc func editTextAction(_ sender: UIBarButtonItem) {
        textView.resignFirstResponder()
        container.isHidden = false
        if let toolType = UNUMTextEditorToolType(rawValue: sender.tag) {

            //set container height according to toolbar type
            containerHeight.constant = getToolBarHeight(toolbarType: toolType)

            //init viewController
            let textData = UNUMAttributeStringStruct()
            if textEditorViewController == nil {

                textEditorViewController = UNUMTextEditorToolBarViewController(attributeString: textData, toolType: toolType)
                textEditorViewController?.delegate = self
                // Add to view.
                willMove(toParent: textEditorViewController)
                container.addSubview(textEditorViewController!.view)
                addChild(textEditorViewController!)
                didMove(toParent: textEditorViewController)

                //add constraints
                textEditorViewController?.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    textEditorViewController!.view.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
                    textEditorViewController!.view.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
                    textEditorViewController!.view.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
                    textEditorViewController!.view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0)]
                )
            } else {
                textEditorViewController?.resetToolBar(attributeStringData: textData, toolType: toolType)
            }
        }
    }

    func getTextElement(index: Int) -> NSTextAlignment {
        switch index {
        case 0: return .left
        case 1: return .center
        case 2: return .right
        case 3: return .natural
        default: return .left
        }
    }

    //build string
    func buildAttributeString(_ attributes: UNUMAttributeStringStruct) {
        let attributeString = NSMutableAttributedString(string: textView.text ?? "")
        let range = NSRange(location: 0, length: textView.text?.count ?? 0)
        let font = UIFont(name: attributes.fontName, size: CGFloat(attributes.fontSize))
        attributeString.addAttribute(.font, value: font as Any, range: range)
        attributeString.addAttribute(.kern, value: attributes.letterSpacing, range: range)
        // add line spacing attribute
        let lineSpacing = attributes.lineSpacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(lineSpacing)
        paragraphStyle.alignment = getTextElement(index: attributes.alignment)
        attributeString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        attributeString.addAttribute(.foregroundColor, value: UIColor(rgb: attributes.fontColor), range: range)
        textView.attributedText = attributeString
    }
}

extension ViewController: UNUMTextEditorDelegaet {
    func didChangeTextAttribute(_ attributeData: UNUMAttributeStringStruct) {
        buildAttributeString(attributeData)
    }

    func didSave() {

        container.isHidden = true
    }

    func didCancel() {
        container.isHidden = true
    }

}

