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
    var attributeStringData: UNUMAttributeStringStruct!
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
            sliderView.value = Float(attributeStringData.fontSize)
            labelLeading.constant = CGFloat((attributeStringData.fontSize - 1) / 99) * (self.frame.width - 52) + 25
        } else if editorType == .EditLetterSpacing {
            sliderView.value = Float(attributeStringData.letterSpacing)
            valueLabel.text = "\(attributeStringData.letterSpacing)"
            labelLeading.constant = CGFloat((attributeStringData.letterSpacing - 1) / 99) * (self.frame.width - 52) + 25
        } else if editorType == .EditLineSpacing {
            sliderView.value = Float(attributeStringData.lineSpacing)
            valueLabel.text = "\(attributeStringData.lineSpacing)"
            labelLeading.constant = CGFloat((attributeStringData.lineSpacing - 1) / 99) * (self.frame.width - 52) + 25
        }
        sliderView.setThumbImage(UIImage(named: "sliderKnobLightMode"), for: .normal)
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        // ----------------------------------------------
        //  when slider's value changed, round the value
        //-------------------------------------------------

        sliderView.setValue(Float(Int(sender.value)), animated: true)
        if editorType == .EditSize {
            attributeStringData.fontSize = Float(sender.value)
        } else if editorType == .EditLetterSpacing {
            attributeStringData.letterSpacing = sender.value
        } else if editorType == .EditLineSpacing {
            attributeStringData.lineSpacing = sender.value
        }

        delegate?.didChangeTextAttribute(attributeStringData)
        
        //change text attribulte base on slider value
        labelLeading.constant = CGFloat((sender.value - 1) / 99) * (sender.frame.width - 52) + 25
        valueLabel.text = "\(Int(sender.value))"
    }
}
