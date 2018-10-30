//
//  UILabel+Extension.swift
//  UNUMTextEditor
//
//  Created by Li Zhao on 10/29/18.
//

import UIKit

extension UILabel {

    //add image in label, if afterLabel is true, add image at end of text
    //otherwise add image at front
    func addImage(imageName: String, afterLabel bolAfterLabel: Bool = false)
    {
        let attachment: NSTextAttachment = NSTextAttachment()
        var bundle = Bundle(for: UNUMTextEditorToolBarViewController.self)
        if let path = bundle.path(forResource: "Media", ofType: "bundle") {
            bundle = Bundle(path: path) ?? bundle
        }
        attachment.image = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)

        if (bolAfterLabel)
        {
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text ?? "")
            strLabelText.append(attachmentString)

            self.attributedText = strLabelText
        }
        else
        {
            let strLabelText: NSAttributedString = NSAttributedString(string: "  " + (self.text ?? ""))
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)

            self.attributedText = mutableAttachmentString
        }
    }

    func removeImage()
    {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}

extension UIColor {

    /**
     * Initializes and returns a color using the specified rgb value,
     * interpreted as a hexadecimal number, and the specified opacity value.
     *
     * For example, `UIColor(rgb: 0xFF00FF, a: 0.5)` returns magenta at 50%
     * opacity.
     */
    public  convenience init(rgb: Int, a: CGFloat) {
        let r = CGFloat((rgb & 0xFF0000) >> 16)
        let g = CGFloat((rgb & 0x00FF00) >> 8)
        let b = CGFloat((rgb & 0x0000FF))

        self.init(red: r/0xFF, green: g/0xFF, blue: b/0xFF, alpha: a)
    }

    /**
     * Initializes and returns a color using the specified rgb value,
     * interpreted as a hexadecimal number. The resulting color is 100% opaque.
     *
     * For example, `UIColor(rgb: 0xFF00FF)` returns pure magenta.
     */
    public  convenience init(rgb: Int) {
        self.init(rgb: rgb, a: 1.0)
    }

}
