//
//  NSAttributedString+Extension.swift
//  UNUMTextEditor
//
//  Created by Li Zhao on 11/7/18.
//

import Foundation
import UIKit

public extension NSMutableAttributedString {

    var fullStringRang: NSRange {
        return NSRange(location: 0, length: string.count)
    }

    public var fullStringAttributes:[NSAttributedString.Key : Any] {
        return self.attributes(at: 0, longestEffectiveRange: nil, in: fullStringRang)
    }

    public var fullParagraphStyle: NSMutableParagraphStyle? {
        return fullStringAttributes[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle
    }

    public var fontName: String? {
        if let font = fullStringAttributes[NSAttributedString.Key.font] as? UIFont {
            return font.fontName
        }
        return nil
    }

    public var fontSize: CGFloat? {
        if let font = fullStringAttributes[NSAttributedString.Key.font] as? UIFont {
            return font.pointSize
        }
        return nil
    }

    public var lineSpacing: CGFloat? {
        if let paragraphStyle = fullStringAttributes[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle {
            return paragraphStyle.lineSpacing
        }
        return nil
    }

    public var letterSpacing: CGFloat? {
        return fullStringAttributes[NSAttributedString.Key.kern] as? CGFloat
    }

    public var fontColor: UIColor? {
        return fullStringAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
    }

    public var textAlignment: NSTextAlignment? {
        return fullParagraphStyle?.alignment
    }

    public func setTextAlignment(alignment: Int) {
        if let paragraphStyle = fullParagraphStyle {
            paragraphStyle.alignment = getTextElement(index: alignment)
            var tempAttributes = fullStringAttributes
            tempAttributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
            self.setAttributes(tempAttributes, range: fullStringRang)
        }
    }

    public func setFont(newFontNanme: String?, newSize: CGFloat?) {
        guard let name = newFontNanme ?? self.fontName,
            let size = newSize ?? self.fontSize else {
                return
        }

        if let newFont = UIFont(name: name, size: size) {
            self.addAttribute(.font, value: newFont, range: fullStringRang)
        }
    }

    public func setLetterSpacing(size: Float) {
        self.addAttribute(.kern, value: size, range: fullStringRang)
    }

    public func setLineSpacing(size: Float) {
        if let paragraphStyle = fullParagraphStyle {
            paragraphStyle.lineSpacing = CGFloat(size)
            var tempAttributes = fullStringAttributes
            tempAttributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
            self.setAttributes(tempAttributes, range: fullStringRang)
        }
    }

    public func setForegroundColor(color: UIColor) {
        self.addAttribute(.foregroundColor, value: color, range: fullStringRang)
    }

    private func getTextElement(index: Int) -> NSTextAlignment {
        switch index {
        case 0: return .left
        case 1: return .center
        case 2: return .right
        case 3: return .natural
        default: return .left
        }
    }
}
