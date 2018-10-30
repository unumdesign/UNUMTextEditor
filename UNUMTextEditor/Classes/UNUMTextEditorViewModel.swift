//
//  UNUMTextEditorViewModel.swift
//  UNUMTextEditor
//
//  Created by Li Zhao on 10/30/18.
//

import Foundation

class UNUMTextEditorViewModel {

    var attributeStringData: UNUMAttributeStringStruct
    var toolType: UNUMTextEditorToolType


    init(attributeStringData: UNUMAttributeStringStruct, toolType: UNUMTextEditorToolType) {
        self.attributeStringData = attributeStringData
        self.toolType = toolType
    }
}
