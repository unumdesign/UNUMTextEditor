//
//  NSAttributeStringStruct.swift
//  UNUMTextEditor
//
//  Created by Li Zhao on 10/30/18.
//

import Foundation

public struct UNUMAttributeStringStruct {
    public var text: String = "Test String"
    public var fontName: String = "Helvetica"
    public var fontSize: Float = 12
    public var letterSpacing: Float = 1
    public var lineSpacing: Float = 1
    public var fontColor: Int = 0
    public var alignment: Int = 0
    public var backgroundColor: Int = 1

    public init(){}

    public init(text: String, fontName: String, fontSize: Float, letterSpacing: Float,
                lineSpacing: Float, fontColor: Int, alignment: Int, backgroundColor: Int) {
        self.text = text
        self.fontName = fontName
        self.fontColor = fontColor
        self.letterSpacing = letterSpacing
        self.lineSpacing = lineSpacing
        self.fontSize = fontSize
        self.alignment = alignment
        self.backgroundColor = backgroundColor
    }
}
