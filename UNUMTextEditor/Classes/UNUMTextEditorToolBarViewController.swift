//
//  TextEditorToolBarViewController.swift
//  UNUMTextEditor
//
//  Created by Li Zhao on 10/29/18.
//

import UIKit

public enum UNUMTextEditorToolType: Int {
    case EditFont = 1
    case EditSize
    case EditAlignment
    case EditLetterSpacing
    case EditLineSpacing
    case EditColor
    case Close
}

public protocol UNUMTextEditorDelegaet: class {
    func didChangeTextAttribute(_ attributeData: UNUMAttributeStringStruct)
    func didSave()
    func didCancel()
}

protocol UNUMToolBarDelegaet: class {
    func didChangeTextAttribute(_ attributeData: UNUMAttributeStringStruct)

}

public class UNUMTextEditorToolBarViewController: UIViewController {

    @IBOutlet var toolTitle: UILabel!
    @IBOutlet var infoButton: UIButton!
    @IBOutlet var toolBarContainer: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var pickerView: HorizontalPickerView!

    var toolBarModel: UNUMTextEditorToolType!
    public weak var delegate: UNUMTextEditorDelegaet?
    var viewModel: UNUMTextEditorViewModel!

    let bundle: Bundle = {
        return  Bundle(for: UNUMTextEditorToolBarViewController.self)
    }()

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public convenience init(attributeString: UNUMAttributeStringStruct, toolType: UNUMTextEditorToolType) {
        let bundle = Bundle(for: UNUMTextEditorToolBarViewController.self)
        self.init(nibName: "UNUMTextEditorToolBarViewController", bundle: bundle)
        self.viewModel = UNUMTextEditorViewModel(attributeStringData: attributeString, toolType: toolType)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupToolBar()
    }

    public func resetToolBar(attributeStringData: UNUMAttributeStringStruct, toolType: UNUMTextEditorToolType) {
        self.viewModel.attributeStringData = attributeStringData
        self.viewModel.toolType = toolType
        setupToolBar()
    }

    private func setupToolBar() {

        for view in self.toolBarContainer.subviews {
            view.removeFromSuperview()
        }

        switch viewModel.toolType {

        case .EditFont:
            setupEditFontView()
            toolTitle.text = " Fonts"
            toolTitle.addImage(imageName: "font-icon-small")
            infoButton.isHidden = true
        case .EditSize:
            setupEditSizeView()
            toolTitle.text = " Text Size"
            toolTitle.addImage(imageName: "size-icon")
            infoButton.isHidden = true
        case .EditAlignment:
            setupEditAlignmentView()
            toolTitle.text = " Text Alignment"
            toolTitle.addImage(imageName: "textAlignment")
            infoButton.isHidden = true
        case .EditLetterSpacing:
            setupEditLetterSpacingView()
            toolTitle.text = " Letter Spacing"
            toolTitle.addImage(imageName: "textAlignment")
            infoButton.isHidden = true
        case .EditLineSpacing:
            setupEditLineSpacingView()
            toolTitle.text = " Line Spacing"
            toolTitle.addImage(imageName: "textAlignment")
            infoButton.isHidden = true
        case .EditColor:
            setupEditColorView()
            toolTitle.text = " Text Color"
            toolTitle.addImage(imageName: "color-icon-small")
            infoButton.isHidden = true
        case .Close:
            break
        }
    }

    fileprivate func addConstraints(_ view: UIView, parentView: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0),
            view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0)]
        )
    }

    func setupEditFontView() {
        if let fontToolBar = bundle.loadNibNamed("EditFontToolBar", owner: nil, options: nil)?.first as? EditFontToolBar {
            self.toolBarContainer.addSubview(fontToolBar)
            addConstraints(fontToolBar, parentView: toolBarContainer)
            fontToolBar.attributeStringData = viewModel.attributeStringData
            fontToolBar.getFontFamily()
            fontToolBar.setupCollectionViews()
            fontToolBar.delegate = self
        }
    }

    func setupEditSizeView() {
        if let fontSizeToolBar = bundle.loadNibNamed("EditTextSliderToolBar", owner: nil, options: nil)?.first as? EditTextSliderToolBar {
            fontSizeToolBar.editorType = .EditSize
            self.toolBarContainer.addSubview(fontSizeToolBar)
            addConstraints(fontSizeToolBar, parentView: toolBarContainer)
            fontSizeToolBar.attributeStringData = viewModel.attributeStringData
            fontSizeToolBar.setupToolBar()
            fontSizeToolBar.delegate = self
        }
    }

    func setupEditAlignmentView() {
        if let fontAlignmentToolBar = bundle.loadNibNamed("EditFontAlignmentToolBar", owner: nil, options: nil)?.first as? EditFontAlignmentToolBar {
            self.toolBarContainer.addSubview(fontAlignmentToolBar)
            addConstraints(fontAlignmentToolBar, parentView: toolBarContainer)
            fontAlignmentToolBar.attributeStringData = viewModel.attributeStringData
            fontAlignmentToolBar.delegate = self
        }
    }

    func setupEditColorView() {
        if let editColorToolBarToolBar = bundle.loadNibNamed("EditColorToolBar", owner: nil, options: nil)?.first as? EditColorToolBar {
            self.toolBarContainer.addSubview(editColorToolBarToolBar)
            addConstraints(editColorToolBarToolBar, parentView: toolBarContainer)
            editColorToolBarToolBar.attributeStringData = viewModel.attributeStringData
            editColorToolBarToolBar.setupCollectionView()
            editColorToolBarToolBar.delegate = self
        }
    }

    func setupEditLetterSpacingView() {
        if let fontSizeToolBar = bundle.loadNibNamed("EditTextSliderToolBar", owner: nil, options: nil)?.first as? EditTextSliderToolBar {
            fontSizeToolBar.editorType = .EditLetterSpacing
            self.toolBarContainer.addSubview(fontSizeToolBar)
            addConstraints(fontSizeToolBar, parentView: toolBarContainer)
            fontSizeToolBar.attributeStringData = viewModel.attributeStringData
            fontSizeToolBar.setupToolBar()
            fontSizeToolBar.delegate = self
        }
    }

    func setupEditLineSpacingView() {
        if let fontSizeToolBar = bundle.loadNibNamed("EditTextSliderToolBar", owner: nil, options: nil)?.first as? EditTextSliderToolBar {
            fontSizeToolBar.editorType = .EditLineSpacing
            self.toolBarContainer.addSubview(fontSizeToolBar)
            addConstraints(fontSizeToolBar, parentView: toolBarContainer)
            fontSizeToolBar.attributeStringData = viewModel.attributeStringData
            fontSizeToolBar.setupToolBar()
            fontSizeToolBar.delegate = self
        }
    }
    @IBAction func cancelOnClick(_ sender: Any) {
        delegate?.didCancel()
    }

    @IBAction func saveOnClick(_ sender: Any) {
        delegate?.didSave()
    }
}

extension UNUMTextEditorToolBarViewController: UNUMToolBarDelegaet {
    func didChangeTextAttribute(_ attributeData: UNUMAttributeStringStruct) {
        viewModel.attributeStringData = attributeData
        delegate?.didChangeTextAttribute(attributeData)
    }
}
