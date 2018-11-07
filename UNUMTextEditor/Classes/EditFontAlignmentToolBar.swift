
//
//  EdutFontAligmentToolBar.swift
//  UNUM
//
//  Created by Li Zhao on 8/1/18.
//  Copyright © 2018 UNUM Inc. All rights reserved.
//

import UIKit

class EditFontAlignmentToolBar: UIView {

    var attributedString: NSMutableAttributedString!
    var delegate: UNUMToolBarDelegaet?
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBAction func leftAlignmentAction(_ sender: UIButton) {
        attributedString.setTextAlignment(alignment: 0)
        delegate?.didChangeTextAttribute(attributedString)
    }

    @IBAction func centerAlignmentAction(_ sender: UIButton) {
        attributedString.setTextAlignment(alignment: 1)
        delegate?.didChangeTextAttribute(attributedString)
    }

    @IBAction func rightAlignmentAction(_ sender: UIButton) {
        attributedString.setTextAlignment(alignment: 2)
        delegate?.didChangeTextAttribute(attributedString)
    }

    @IBAction func justifiedAlignmentAction(_ sender: UIButton) {
       attributedString.setTextAlignment(alignment: 3)
        delegate?.didChangeTextAttribute(attributedString)
    }
}
