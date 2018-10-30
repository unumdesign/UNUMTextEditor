//
//  EditFontToolBar.swift
//  UNUM
//
//  Created by Li Zhao on 7/25/18.
//  Copyright © 2018 UNUM Inc. All rights reserved.
//

import UIKit

class EditFontToolBar: UIView {

    @IBOutlet var fontToolView: HorizontalPickerView!
    @IBOutlet var styleToolView: HorizontalPickerView!

    weak var delegate: UNUMToolBarDelegaet?
    var attributeStringData: NSAttributeStringStruct!
    var fontData = [String]()
    var fontSizeArray = [CGFloat]()

    var styleData = [String: [String]]()

    var fontInitX: CGFloat = 0
    var styleInitX: CGFloat = 0

    var selectedFont: String? {
        didSet {
            styleToolView.scrollToItem(0, animated: false)
            styleToolView.reloadData()
        }
    }

    var seletedStyle: Int = 0

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupCollectionViews() {

        fontToolView.dataSource = self
        fontToolView.delegate = self

        styleToolView.delegate = self
        styleToolView.dataSource = self

        self.fontToolView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.fontToolView.font = UIFont(name: fontData.first!, size: 14)!
        self.fontToolView.highlightedFont = UIFont(name: fontData.first!, size: 12)!
        self.fontToolView.interitemSpacing = 10.0
        self.fontToolView.pickerViewStyle = .flat
        self.fontToolView.maskDisabled = false

        self.styleToolView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.styleToolView.font = UIFont(name: (styleData[selectedFont!]?.first!)!, size: 14)!
        self.styleToolView.highlightedFont = UIFont(name: fontData.first!, size: 12)!
        self.styleToolView.interitemSpacing = 10.0
        self.styleToolView.pickerViewStyle = .flat
        self.styleToolView.maskDisabled = false
    }

    func getFontFamily() {
        for family in UIFont.familyNames {

            let sName: String = family as String
            print("family: \(sName)")

            // ----------------------------------------------
            //  if font donesn't have any style, skip it, because
            //  it causes crash
            //-------------------------------------------------
            if UIFont.fontNames(forFamilyName: sName).count != 0 {
                fontData.append(family)
            }

            // ----------------------------------------------
            //  save font styles
            //-------------------------------------------------
            for name in UIFont.fontNames(forFamilyName: sName) {
                if styleData[sName] == nil {
                    styleData[sName] = [String]()
                }
                styleData[sName]?.append(name)
            }
        }

        // ----------------------------------------------
        //  setup selected font when no font selected
        //-------------------------------------------------
        if let firstFont = fontData.first {
            selectedFont = firstFont
        }
        fontToolView.reloadData()
    }
}

extension EditFontToolBar: HorizontalPickerViewDelegate {
    func pickerView(_ pickerView: HorizontalPickerView, didSelectItem item: Int) {
        if pickerView.tag == 1 {
            selectedFont = fontData[item]
            guard let selected = selectedFont,
                let stylename = styleData[selected]?.first else {
                    attributeStringData.fontName = selectedFont ?? attributeStringData.fontName
                    delegate?.didChangeTextAttribute(attributeStringData)
                return
            }
            attributeStringData.fontName = stylename
            delegate?.didChangeTextAttribute(attributeStringData)
        } else if pickerView.tag == 2 {
            guard let selected = selectedFont, let styleArray = styleData[selected] else {
                return
            }

            attributeStringData.fontName = styleArray[item]
            delegate?.didChangeTextAttribute(attributeStringData)
            seletedStyle = item
        }
    }
}

extension EditFontToolBar: HorizontalPickerViewDataSource {
    func numberOfItemsInPickerView(_ pickerView: HorizontalPickerView) -> Int {
        if pickerView.tag == 1 {
             return fontData.count
        } else {
            guard let selected = selectedFont, let styleArray = styleData[selected] else {
                return 1
            }
            return styleArray.count
        }
    }

    func pickerView(_ pickerView: HorizontalPickerView, titleForItem item: Int) -> String {
        if pickerView.tag == 1 {
            return fontData[item]
        } else if pickerView.tag == 2 {

            guard let selected = selectedFont, let styleArray = styleData[selected] else {
                return "Regular"
            }

            // ----------------------------------------------
            //  remove font family name, only show style name
            //-------------------------------------------------
            let styleName = styleArray[item]
            var styleText = ""
            if let range = styleName.range(of: "-") {
                styleText = String(styleName[range.upperBound...])
                return styleText
            } else {
                return "Regular"
            }
        }
        return ""
    }
}
