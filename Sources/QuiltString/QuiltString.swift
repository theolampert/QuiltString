import Foundation

import Quilt

public class QuiltString: ObservableObject {
    public init(
        quilt: Quilt = .init(user: UUID()),
        string: String = ""
    ) {
        self.quilt = quilt
        self.string = string
    }

    public var quilt: Quilt = .init(user: UUID())

    @Published
    public var string: String = ""

    private func insert(character: Character, atIndex: Int) {
        quilt.insert(character: character, atIndex: atIndex)
    }

    private func remove(atIndex: Int) {
        quilt.remove(atIndex: atIndex)
    }

    public func addMark(mark: MarkType, fromIndex: Int, toIndex: Int) {
        quilt.addMark(mark: mark, fromIndex: fromIndex, toIndex: toIndex)
        createText()
    }

    func getSpanMarkerIndex(marker: SpanMarker) -> Int {
        switch marker {
        case let .before(id):
            return quilt.currentContent.firstIndex(where: { $0.id == id }) ?? 0
        case let .after(id):
            return quilt.currentContent.firstIndex(where: { $0.id == id })!
        }
    }

    private func createText() {
        string = quilt.currentContent.reduce(into: "") { acc, curr in
            if case let .insert(character) = curr.type {
                acc.append(character)
            }
        }
    }

    public func set(newText: String) {
        for change in newText.difference(from: string) {
            switch change {
            case let .insert(offset, element, _):
                insert(character: element, atIndex: offset)
            case let .remove(offset, _, _):
                remove(atIndex: offset)
            }
        }

        createText()
    }

    public func merge(_ updates: Quilt) {
        quilt.merge(updates)
        createText()
    }
}
