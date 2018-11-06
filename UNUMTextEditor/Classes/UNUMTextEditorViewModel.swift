//
//  UNUMTextEditorViewModel.swift
//  UNUMTextEditor
//
//  Created by Li Zhao on 10/30/18.
//

import Foundation

class UNUMTextEditorViewModel {

    var attributeStringData: UNUMAttributeStringStruct
    var toolType: UNUMTextEditorToolType?


    init(attributeStringData: UNUMAttributeStringStruct) {
        self.attributeStringData = attributeStringData
    }

    func getToolBarHeight(toolbarType: UNUMTextEditorToolType) -> CGFloat {
        switch toolbarType {
        case .EditFont: return 181
        case .EditSize: return 144
        case .EditAlignment: return 163
        case .EditLetterSpacing: return 144
        case .EditLineSpacing: return 144
        case .EditColor: return 157
        case .Close: return 0
        }
    }
}
