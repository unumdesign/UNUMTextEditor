//
//  EditColorToolBar.swift
//  UNUM
//
//  Created by Li Zhao on 8/1/18.
//  Copyright © 2018 UNUM Inc. All rights reserved.
//

import UIKit

class EditColorToolBar: UIView {

    @IBOutlet var collectionView: UICollectionView!

    let colorData = [0xFC2F00, 0xF7AB59, 0xFEEA00, 0x008040, 0x005D2F, 0x2424E4, 0x000000, 0xFFFFFF,
                     0xE5A397, 0x5D7469, 0x000554, 0x051C3A, 0x4a4a4a, 0xCEBDA5, 0xFDDAE1, 0xFE0000,
                     0xFE8000, 0xFFFF01, 0xBFF046, 0x00F600, 0x01FFFF, 0x017FFF, 0xFF00FE, 0x848F87,
                     0x8FAD9C, 0xDEDDDB, 0xBCBCB4, 0x555757, 0x4A505E, 0x3E526D, 0xBCD6D8, 0xB4534C,
                     0xE3B488, 0xD9C9B9, 0xE4C1B8, 0xE6D3CD, 0xEFDFBE, 0xF7E3A9, 0xFDF5EC]

    var editingTextView: TextEditorView?
    var textElement: StoryTextPageElement?
    var editingCell: StoryPageCollectionViewCanvasCell?

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupCollectionView() {
        let nib = UINib(nibName: "ColorEditorCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ColorEditorCollectionViewCell")
    }
}

extension EditColorToolBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        editingTextView?.textView.textColor = UIColor(rgb: colorData[indexPath.row])
        textElement?.fontColor = colorData[indexPath.row]
        editingCell?.fullCellCanvasView.backgroundColor =  UIColor(rgb: colorData[indexPath.row])
        pageElement?.backgroundColor = colorData[indexPath.row]
        collectionView.reloadData()
    }
}

extension EditColorToolBar: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorEditorCollectionViewCell", for: indexPath) as! ColorEditorCollectionViewCell
        var selected = editingTextView?.textView.textColor
        if selected == nil {
            selected = UIColor(rgb: (pageElement?.backgroundColor ?? 0))
        }
        let sameColor = selected == UIColor(rgb: colorData[indexPath.row])
        cell.setupColorButton(colorInt: colorData[indexPath.row], selected: sameColor)
        return cell
    }
}

extension EditColorToolBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.width - 162) / 8
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = (self.width - 162) / 8
        let top = (self.height - width) / 2
        return UIEdgeInsets(top: top, left: 18, bottom: top, right: 18)
    }
}
