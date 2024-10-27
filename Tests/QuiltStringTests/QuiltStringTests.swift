import Quilt
@testable import QuiltString
import XCTest

final class QuiltStringTests: XCTestCase {
    func testOpIDGreater() throws {
        let userA = UUID()
        let userB = UUID()

        let opIDA = OpID(counter: 0, id: userA)
        let opIDB = OpID(counter: 1, id: userB)

        XCTAssertTrue(opIDA < opIDB)
    }

    func testOpIDEqual() throws {
        let userA = UUID(uuidString: "E2DFDB75-A3D9-4B55-9312-111EF297D566")!
        let userB = UUID(uuidString: "D777AB4C-54BF-4381-9051-DA1945F9686C")!

        let opIDA = OpID(counter: 0, id: userA)
        let opIDB = OpID(counter: 0, id: userB)

        XCTAssertTrue(opIDA > opIDB)
    }

    func testEditMerging() throws {
        let clientA = QuiltString()
        let clientB = QuiltString()

        let original = "The fox jumped."

        clientA.set(newText: original)
        clientB.merge(clientA.quilt)

        XCTAssertEqual(original, clientA.string)
        XCTAssertEqual(original, clientB.string)

        clientA.set(newText: "The quick fox jumped.")
        clientB.set(newText: "The fox jumped over the dog.")

        clientA.merge(clientB.quilt)
        clientB.merge(clientA.quilt)

        let expected = "The quick fox jumped over the dog."

        XCTAssertEqual(expected, clientA.string)
        XCTAssertEqual(expected, clientB.string)

        clientA.set(newText: "The quick fox sprang over the dog.")
        clientB.merge(clientA.quilt)

        XCTAssertEqual("The quick fox sprang over the dog.", clientA.string)
        XCTAssertEqual("The quick fox sprang over the dog.", clientB.string)
    }

    func testUnderlineAttributedString() throws {
        let clientA = QuiltString()

        clientA.set(newText: "Hello World")
        clientA.addMark(mark: .underline, fromIndex: 0, toIndex: 10)

        let expected = NSMutableAttributedString("Hello World")
        expected.setTextAttribute(
            .underlineStyle, to: true, at: NSRange(location: 0, length: 11)
        )
        let fontBase = Font.systemFont(ofSize: 16)
        expected.setTextAttribute(
            .font, to: fontBase, at: NSRange(location: 0, length: 11)
        )
        XCTAssertTrue(clientA.attString.isEqual(to: expected))
    }

    func testRemoveUnderlineAttributedString() throws {
//        let clientA = QuiltString()
//
//        clientA.set(newText: "Hello World")
//        clientA.addMark(mark: .underline, fromIndex: 6, toIndex: 10)
//
//        let exptected = NSMutableAttributedString("Hello World")
//
//        clientA.set(newText: "Hello ")
//
//        XCTAssertTrue(clientA.attString.isEqual(to: exptected))
    }

    func testBoldAttributedString() throws {
        let clientA = QuiltString()

        clientA.set(newText: "Hello World")
        clientA.addMark(mark: .bold, fromIndex: 0, toIndex: 10)

        let exptected = NSMutableAttributedString("Hello World")
        exptected.makeBold(range: NSRange(location: 0, length: 11))

        XCTAssertTrue(clientA.attString.isEqual(to: exptected))
    }

    func testItalicAttributedString() throws {
        let clientA = QuiltString()

        clientA.set(newText: "Hello World")
        clientA.addMark(mark: .italic, fromIndex: 0, toIndex: 10)

        let expected = NSMutableAttributedString("Hello World")
        expected.makeItalic(range: NSRange(location: 0, length: 11))

        print(clientA.attString)
        XCTAssertTrue(clientA.attString.isEqual(to: expected))
    }

    func testLoadLongerString() throws {
        let str = """
        EXTRACTS xvii 

        ****** an( j ^e breath of the whale is fre- 
        quently attended with such an insupportable smell, as to 
        bring on a disorder of the brain.' 

        Ulloa's South America. 

        1 To fifty chosen sylphs of special note, 
        We trust the important charge, the petticoat. 
        Oft have we known that seven-fold fence to fail, 
        Tho' stuffed with hoops and armed with ribs of whale.' 
        
        Rape of the Lock. 

        ' If we compare land animals in respect to magnitude, with 
        those that take up their abode in the deep, we shall find they 
        will appear contemptible in the comparison. The whale is 
        doubtless the largest animal in creation.' 

        Goldsmith's Nat. Hist. 

        ' If you should write a fable for little fishes, you would 
        make them speak like great whales.' 

        Goldsmith to Johnson. 

        ' In the afternoon we saw what was supposed to be a rock, 
        but it was found to be a dead whale, which some Asiatics had 
        killed, and were then towing ashore. They seemed to en- 
        deavour to conceal themselves behind the whale, in order to 
        avoid being seen by us.' Cook's Voyages. 

        ' The larger whales, they seldom venture to attack. They 
        stand in so great dread of some of them, that when out at 
        sea they are afraid to mention even their names, and carry 
        dung, lime-stone, juniper-wood, and some other articles of 
        the same nature in their boats, in order to terrify and prevent 
        their too near approach.' 

        Uno Von Troil's Letters on Banks' s and 
        Solander's Voyage to Iceland in 1772. 

        ' The Spermacetti Whale found by the Nantuckois, is 
        an active, fierce animal, and requires vast address and bold- 
        ness in the fishermen.' 

        Thomas Jefferson's Whale Memorial to the 
        French Minister in 1778. 

        1 And pray, sir, what in the world is equal to it ? ' 

        Edmund Burke's Reference in Parliament 

        to the Nantucket Whale Fishery. 
        VOL. I. b 

        xviii MOBY-DICK 

        ' Spain a great whale stranded on. the shores of Europe.' 

        Edmund Burke. (Somewhere.} 

        ' A tenth branch of the king's ordinary revenue, said to 
        be grounded on the consideration of his guarding and pro- 
        tecting the seas from pirates and robbers, is the right to 
        royal fish, which are whale and sturgeon. And these, when 
        either thrown ashore or caught near the coast, are the pro- 
        perty of the king.' Blackstone. 
        """

        let clientA = QuiltString()
        let start = CFAbsoluteTimeGetCurrent()
        clientA.set(newText: str)
        let diff = CFAbsoluteTimeGetCurrent() - start
        print("Took \(diff) seconds")
    }
}
