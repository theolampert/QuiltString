#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif
import Foundation

extension QuiltString {
    public var attString: NSMutableAttributedString {
        let attString = NSMutableAttributedString(string: string)
        let fontBase = Font.systemFont(ofSize: 16)
        attString.setTextAttribute(
            .font, to: fontBase, at: NSRange(location: 0, length: string.count)
        )
        return applyFormatting(string: attString)
    }

    private func applyFormatting(string: NSMutableAttributedString) -> NSMutableAttributedString {
        for operation in quilt.operationLog {
            if case let .addMark(type, start, end) = operation.type {
                let startIndex = getSpanMarkerIndex(marker: start)
                let endIndex = getSpanMarkerIndex(marker: end)
                let range = NSRange(
                    location: startIndex,
                    length: endIndex - startIndex + 1
                )
                switch type {
                case .underline:
                    string.setTextAttribute(
                        .underlineStyle, to: true, at: range
                    )
                case .bold:
                    string.makeBold(range: range)
                case .italic:
                    string.makeItalic(range: range)
                }
            }
        }

        return string
    }
}
