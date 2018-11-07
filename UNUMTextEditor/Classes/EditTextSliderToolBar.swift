//
//  EditFontSizeToolBar.swift
//  UNUM
//
//  Created by Li Zhao on 7/31/18.
//  Copyright © 2018 UNUM Inc. All rights reserved.
//

import UIKit

class EditTextSliderToolBar: UIView {

    @IBOutlet var sliderView: UISlider!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var labelLeading: NSLayoutConstraint!
    var editorType: UNUMTextEditorToolType!
    var attributedString: NSMutableAttributedString!
    weak var delegate: UNUMToolBarDelegaet?

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupToolBar() {

        // ----------------------------------------------
        //  init slider value and label value
        //  if fontsize is nill, use 14 as default value
        //-------------------------------------------------
        if editorType == .EditSize {
            let size = attributedString.fontSize ?? 12
            sliderView.value = Float(size)
            labelLeading.constant = CGFloat((size - 1) / 99) * (self.frame.width - 52) + 25
        } else if editorType == .EditLetterSpacing {
            let letterSpacing = attributedString.letterSpacing ?? 1
            sliderView.value = Float(letterSpacing)
            valueLabel.text = "\(letterSpacing)"
            labelLeading.constant = CGFloat((letterSpacing - 1) / 99) * (self.frame.width - 52) + 25
        } else if editorType == .EditLineSpacing {
            let lineSpacing = attributedString.lineSpacing ?? 1
            sliderView.value = Float(lineSpacing)
            valueLabel.text = "\(lineSpacing)"
            labelLeading.constant = CGFloat((lineSpacing - 1) / 99) * (self.frame.width - 52) + 25
        }
        sliderView.setThumbImage(UIImage(named: "sliderKnobLightMode"), for: .normal)
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        // ----------------------------------------------
        //  when slider's value changed, round the value
        //-------------------------------------------------

        sliderView.setValue(Float(Int(sender.value)), animated: true)
        if editorType == .EditSize {
            attributedString.setFont(newFontNanme: nil, newSize: CGFloat(sender.value))
        } else if editorType == .EditLetterSpacing {
            attributedString.setLetterSpacing(size: sender.value)
        } else if editorType == .EditLineSpacing {
            attributedString.setLineSpacing(size: sender.value)
        }

        delegate?.didChangeTextAttribute(attributedString)
        
        //change text attribulte base on slider value
        labelLeading.constant = CGFloat((sender.value - 1) / 99) * (sender.frame.width - 52) + 25
        valueLabel.text = "\(Int(sender.value))"
    }
}
