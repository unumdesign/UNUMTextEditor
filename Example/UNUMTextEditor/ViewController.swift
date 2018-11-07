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
    var textEditorToolbarViewController: UNUMTextEditorToolBarViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyBoardToolbar()
        textView.delegate = self
        textView.becomeFirstResponder()
    }

    func setupKeyBoardToolbar() {
        let atttibutedSting = NSMutableAttributedString(attributedString: textView.attributedText)
        textEditorToolbarViewController = UNUMTextEditorToolBarViewController(attributedString: atttibutedSting)
        textEditorToolbarViewController?.delegate = self
        textView.inputAccessoryView = textEditorToolbarViewController?.keyboardToolBar()
        // Add to view.
        willMove(toParent: textEditorToolbarViewController)
        self.view.addSubview(textEditorToolbarViewController!.view)
        addChild(textEditorToolbarViewController!)
        didMove(toParent: textEditorToolbarViewController!)
        textEditorToolbarViewController?.setupTextEditorConstraints()
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let atttibutedSting = NSMutableAttributedString(attributedString: textView.attributedText)
        textEditorToolbarViewController?.reset(attributedString: atttibutedSting)
    }
}

extension ViewController: UNUMTextEditorDelegate {
    func didChangeTextAttribute(attributedString: NSMutableAttributedString) {
        self.textView.attributedText = attributedString
        self.textView.reloadInputViews()
    }

    func didSave() {
        textView.becomeFirstResponder()
    }

    func didCancel() {
        textView.becomeFirstResponder()
    }
}

