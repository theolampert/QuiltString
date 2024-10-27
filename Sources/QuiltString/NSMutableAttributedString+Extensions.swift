#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif
import Foundation

#if canImport(AppKit)
typealias Font = NSFont
#elseif canImport(UIKit)
typealias Font = UIFont
#endif

public extension NSMutableAttributedString {
    func setTextAttribute(_ key: Key, to newValue: Any, at range: NSRange) {
        let safeRange = safeRange(for: range)
        guard length > 0, range.location >= 0 else { return }
        beginEditing()
        removeAttribute(key, range: safeRange)
        addAttribute(key, value: newValue, range: safeRange)
        endEditing()
    }

    func setAttributes(_ attrs: [NSAttributedString.Key: Any], range: NSRange) {
        let safeRange = self.safeRange(for: range)
        guard length > 0, safeRange.location >= 0 else { return }
        beginEditing()
        attrs.forEach { key, value in
            removeAttribute(key, range: safeRange)
            addAttribute(key, value: value, range: safeRange)
        }
        endEditing()
    }

    func makeBold(range: NSRange) {
        let boldFont = Font.boldSystemFont(ofSize: Font.systemFontSize)
        setTextAttribute(.font, to: boldFont, at: range)
    }

    func makeItalic(range: NSRange) {
        let italicFont = Font.systemFont(ofSize: Font.systemFontSize)
        italicFont.fontDescriptor.withSymbolicTraits([.traitItalic])
        setTextAttribute(.font, to: italicFont, at: range)
    }
}
