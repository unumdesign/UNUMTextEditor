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
    var textData: UNUMAttributeStringStruct?

    @IBOutlet var container: UIView!

    @IBOutlet var containerHeight: NSLayoutConstraint!
    var textEditorToolbarViewController: UNUMTextEditorToolBarViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyBoardToolbar()
        textView.becomeFirstResponder()
    }

    func setupKeyBoardToolbar() {
        if textData == nil {
            textData = UNUMAttributeStringStruct()
        }

        if textEditorToolbarViewController == nil {
            textEditorToolbarViewController = UNUMTextEditorToolBarViewController(attributeString: textData!)
            textEditorToolbarViewController?.delegate = self
            textView.inputAccessoryView = textEditorToolbarViewController?.keyboardToolBar()
            // Add to view.
            willMove(toParent: textEditorToolbarViewController)
            self.view.addSubview(textEditorToolbarViewController!.view)
            addChild(textEditorToolbarViewController!)
            didMove(toParent: textEditorToolbarViewController!)
            textEditorToolbarViewController?.setupTextEditorConstraints()
        } else {
            textEditorToolbarViewController?.reset(attributeStringData: textData!)
        }
    }

}

extension ViewController: UNUMTextEditorDelegate {
    func didChangeTextAttribute(_ attributeData: UNUMAttributeStringStruct, attributeString: NSAttributedString) {
        textData = attributeData
        self.textView.attributedText = attributeString
    }

    func didSave() {
        textView.becomeFirstResponder()
    }

    func didCancel() {
        textView.becomeFirstResponder()
    }

}

