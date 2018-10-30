
//
//  EdutFontAligmentToolBar.swift
//  UNUM
//
//  Created by Li Zhao on 8/1/18.
//  Copyright © 2018 UNUM Inc. All rights reserved.
//

import UIKit

class EditFontAlignmentToolBar: UIView {

    var attributeStringData: UNUMAttributeStringStruct!
    var delegate: UNUMToolBarDelegaet?
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBAction func leftAlignmentAction(_ sender: UIButton) {
        attributeStringData.alignment = 0
        delegate?.didChangeTextAttribute(attributeStringData)
    }

    @IBAction func centerAlignmentAction(_ sender: UIButton) {
        attributeStringData.alignment = 1
        delegate?.didChangeTextAttribute(attributeStringData)
    }

    @IBAction func rightAlignmentAction(_ sender: UIButton) {
        attributeStringData.alignment = 2
        delegate?.didChangeTextAttribute(attributeStringData)
    }

    @IBAction func justifiedAlignmentAction(_ sender: UIButton) {
        attributeStringData.alignment = 3
        delegate?.didChangeTextAttribute(attributeStringData)
    }
}
