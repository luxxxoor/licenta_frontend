//
//  CodeInputView.swift
//  onTop
//
//  Created by Alexandru Vrincean on 01.02.2021.
//  Copyright © 2021 Alexandru Vrincean. All rights reserved.
//

import UIKit

#warning("This is a workaround, to be changed with a UITextInput implementation.")

@IBDesignable
final class CodeInputView: UITextField {
    weak var codeInputDelegate: CodeInputViewDelegate?
    private var nextTag = 1
    private var previousValue: String?

    // MARK: - UIResponder
    override var canBecomeFirstResponder: Bool { true }

    // MARK: - UIView
    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    // MARK: - NSCoding
    required public init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        setupDigitLabels()
    }

    private func commonInit() {
        tintColor = .clear
        borderStyle = .none

        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: self, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            guard let text = self.text else { return }
            self.text = nil
            guard let object = notification.object as? CodeInputView, object == self else { return }

            self.setDigits(forText: text)
        }

        setupDigitLabels()
    }

    private func setupDigitLabels() {
        // Add six digitLabels + spacer
        let space = self.frame.width/7
        let startPos = space/4/2 // 1/4 of space is not covered by label, 1/2 of it stands before and after labels
        let labelWidth = space*3/4 // labels cover only 3/4 of their space
        var frame = CGRect(x: startPos, y: 10, width: labelWidth, height: 40)
        for index in 1...3 {
            let digitLabel = UILabel(frame: frame)
            digitLabel.font = .systemFont(ofSize: 42)
            digitLabel.tag = index
            digitLabel.text = "–"
            digitLabel.textAlignment = .center
            addSubview(digitLabel)
            frame.origin.x += space
        }

        frame.origin.x += space

        for index in 4...6 {
            let digitLabel = UILabel(frame: frame)
            digitLabel.font = .systemFont(ofSize: 42)
            digitLabel.tag = index
            digitLabel.text = "–"
            digitLabel.textAlignment = .center
            addSubview(digitLabel)
            frame.origin.x += space
        }
    }

    private func setDigits(forText text: String) {
        for character in text {
            if nextTag < 7 {
                (viewWithTag(nextTag)! as! UILabel).text = "\(character)"
                nextTag += 1

                if nextTag == 7 {
                    var code = ""
                    for index in 1..<nextTag {
                        code += (viewWithTag(index)! as! UILabel).text!
                    }
                    codeInputDelegate?.codeInputView(self, didFinishWithCode: code)
                }
            }
        }
    }

    // MARK: - UIKeyInput
    override var hasText: Bool { nextTag > 1 ? true : false }

    override func deleteBackward() {
        if nextTag > 1 {
            nextTag -= 1
            (viewWithTag(nextTag)! as! UILabel).text = "–"
        }
    }

    func clear() { while nextTag > 1 { deleteBackward() } }

    // MARK: - UITextInputTraits

    override var keyboardType: UIKeyboardType { get { .numberPad } set { } }

    override var textContentType: UITextContentType! {
        get {
            if #available(iOS 12, *) {
                return .oneTimeCode
            } else {
                return nil
            }
        }
        set { }
    }
}

protocol CodeInputViewDelegate: AnyObject {
    func codeInputView(_ codeInputView: CodeInputView, didFinishWithCode code: String)
}
