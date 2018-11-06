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

public protocol UNUMTextEditorDelegate: class {
    func didChangeTextAttribute(_ attributeData: UNUMAttributeStringStruct, attributeString: NSAttributedString)
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
    @IBOutlet var containerHeight: NSLayoutConstraint!

    var toolBarModel: UNUMTextEditorToolType!
    public weak var delegate: UNUMTextEditorDelegate?
    var viewModel: UNUMTextEditorViewModel!

    let bundle: Bundle = {
        return  Bundle(for: UNUMTextEditorToolBarViewController.self)
    }()

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public convenience init(attributeString: UNUMAttributeStringStruct) {
        let bundle = Bundle(for: UNUMTextEditorToolBarViewController.self)
        self.init(nibName: "UNUMTextEditorToolBarViewController", bundle: bundle)
        self.viewModel = UNUMTextEditorViewModel(attributeStringData: attributeString)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupToolBar()
    }


    public func setupTextEditorConstraints() {
        guard let parentVC = self.parent else {
            return
        }
        self.view.isHidden = true
        self.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.view.leadingAnchor.constraint(equalTo: parentVC.view.leadingAnchor, constant: 0),
            self.view.heightAnchor.constraint(equalToConstant: 181),
            self.view.trailingAnchor.constraint(equalTo: parentVC.view.trailingAnchor, constant: 0),
            self.view.bottomAnchor.constraint(equalTo: parentVC.view.bottomAnchor, constant: 0)]
        )
    }

    public func reset(attributeStringData: UNUMAttributeStringStruct) {
        self.viewModel.attributeStringData = attributeStringData
    }

    //set tool bar above ket board
    public func keyboardToolBar() -> UIView {
        let bar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45))

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)

        let fontButton = UIBarButtonItem(image: UIImage(named: "font-icon-small"), style: .plain, target: self, action: #selector(editTextAction(_:)))
        fontButton.tag = 1
        fontButton.tintColor = .black
        let sizeButton = UIBarButtonItem(image: UIImage(named: "size-icon"), style: .plain, target: self, action: #selector(editTextAction(_:)))
        sizeButton.tag = 2
        sizeButton.tintColor = .black
        let alignmentButton = UIBarButtonItem(image: UIImage(named: "textAlignment"), style: .plain, target: self, action: #selector(editTextAction(_:)))
        alignmentButton.tag = 3
        alignmentButton.tintColor = .black
        let letterSpacingButton = UIBarButtonItem(image: UIImage(named: "letterSpacing"), style: .plain, target: self, action: #selector(editTextAction(_:)))
        letterSpacingButton.tag = 4
        letterSpacingButton.tintColor = .black
        let lineSpaceingButton = UIBarButtonItem(image: UIImage(named: "lineSpacing"), style: .plain, target: self, action: #selector(editTextAction(_:)))
        lineSpaceingButton.tag = 5
        lineSpaceingButton.tintColor = .black
        let colorButton = UIBarButtonItem(image: UIImage(named: "color"), style: .plain, target: self, action: #selector(editTextAction(_:)))
        colorButton.tag = 6
        colorButton.tintColor = .black
        bar.items = [fontButton, flexibleSpace, sizeButton, flexibleSpace, alignmentButton, flexibleSpace, letterSpacingButton, flexibleSpace, lineSpaceingButton, flexibleSpace, colorButton]
        return bar
    }

    //add text edtior view
    @objc func editTextAction(_ sender: UIBarButtonItem) {
        if let toolType = UNUMTextEditorToolType(rawValue: sender.tag) {
        self.view.isHidden = false
        self.parent?.view.endEditing(true)
        //set container height according to toolbar type
            containerHeight.constant = viewModel.getToolBarHeight(toolbarType: toolType)
            viewModel.toolType = toolType
            setupToolBar()
        }
    }

    private func setupToolBar() {

        guard let toolType = viewModel.toolType else {
            return
        }

        for view in self.toolBarContainer.subviews {
            view.removeFromSuperview()
        }

        switch toolType {

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
        self.view.isHidden = true
        delegate?.didCancel()
    }

    @IBAction func saveOnClick(_ sender: Any) {
        self.view.isHidden = true
        delegate?.didSave()
    }

    func getTextElement(index: Int) -> NSTextAlignment {
        switch index {
        case 0: return .left
        case 1: return .center
        case 2: return .right
        case 3: return .natural
        default: return .left
        }
    }

    //build string
    func buildAttributeString(_ attributes: UNUMAttributeStringStruct) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: viewModel.attributeStringData.text)
        let range = NSRange(location: 0, length: viewModel.attributeStringData.text.count)
        let font = UIFont(name: attributes.fontName, size: CGFloat(attributes.fontSize))
        attributeString.addAttribute(.font, value: font as Any, range: range)
        attributeString.addAttribute(.kern, value: attributes.letterSpacing, range: range)
        // add line spacing attribute
        let lineSpacing = attributes.lineSpacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(lineSpacing)
        paragraphStyle.alignment = getTextElement(index: attributes.alignment)
        attributeString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        attributeString.addAttribute(.foregroundColor, value: UIColor(rgb: attributes.fontColor), range: range)
        return attributeString
    }
}

extension UNUMTextEditorToolBarViewController: UNUMToolBarDelegaet {
    func didChangeTextAttribute(_ attributeData: UNUMAttributeStringStruct) {
        viewModel.attributeStringData = attributeData
        let attrString = buildAttributeString(attributeData)
        delegate?.didChangeTextAttribute(attributeData, attributeString: attrString)
    }
}
