//
//  ColorEditorCollectionViewCell.swift
//  UNUM
//
//  Created by Li Zhao on 8/1/18.
//  Copyright © 2018 UNUM Inc. All rights reserved.
//

import UIKit

class ColorEditorCollectionViewCell: UICollectionViewCell {

    @IBOutlet var borderView: UIView!
    @IBOutlet var fillView: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupColorButton(colorInt: Int, selected: Bool) {
        self.layoutIfNeeded()

        let colorValue = colorInt == 0xFFFFFF ? 0xC8C8C8 : colorInt
        borderView.backgroundColor = UIColor(rgb: colorInt)
        borderView.layer.borderWidth = 1
        borderView.layer.cornerRadius = borderView.frame.width / 2
        borderView.layer.borderColor = UIColor(rgb: colorValue).cgColor
        fillView.layer.borderColor = UIColor(rgb: colorValue).cgColor
        fillView.layer.borderWidth = 1
        fillView.layer.cornerRadius = fillView.frame.width / 2
        if selected {
            fillView.backgroundColor = UIColor(rgb: colorInt)
        } else {
            fillView.backgroundColor = .white
        }
    }
}
