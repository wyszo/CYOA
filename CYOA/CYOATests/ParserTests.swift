import XCTest
@testable import CYOA

class ParserTests: XCTestCase {
    
    var parser: Parser!
    var mockConsole: MockIOWriter!
    
    override func setUp() {
        mockConsole = MockIOWriter()
        parser = Parser(ioWriter: mockConsole)
    }
    
    override func tearDown() {
        parser = nil
        mockConsole = nil
    }
    
    func testThatParsingEmptyStringReturnsEmptyArray() {
        // given
        let result = parser.parse("")
        
        // then
        XCTAssertEqual(result.count, 0)
    }
    
    func testThatMissingIdDoesntParseAndPrintsAnError() {
        // given
        let noIdText = "text with no id\n choices: 1, 2, 5"
        let result = parser.parse(noIdText)
        
        // then
        
        // no parsed paragraphs returned
        XCTAssertEqual(result.count, 0)
        
        // and an error printed out
        XCTAssertNotNil(mockConsole.lastLine?.count)
    }
    
    func testThatMissingChoiceDoesntParseAndPrintsAnError() {
        // given
        let noChoicesText = "id: 5 text with no choices\n"
        let result = parser.parse(noChoicesText)
        
        // then
        
        // no parsed paragraphs returned
        XCTAssertEqual(result.count, 0)
        
        // and an error printed out
        XCTAssertNotNil(mockConsole.lastLine?.count)
    }
    
    func testThatParsingParagraphSucceeds() {
        // given
        let correctParagraph = "id: 5 foo bar choices: 4, 5, 8"
        let result = parser.parse(correctParagraph)
        
        // then
        
        // 1 paragraph returned
        XCTAssertEqual(result.count, 1)
        
        // no errors printed out
        XCTAssertNil(mockConsole.lastLine?.count)
        
        // returned paragraph contains correct data
        XCTAssertEqual(result[0].text, "foo bar ")
        XCTAssertEqual(result[0].choices, [4, 5, 8])
    }
    
    func testThatParsingTwoParagraphsWorks() {
        // given
        let correctParagraphs = "id: 5 foo bar choices: 4, 5, 8 --- next --- id: 8 second paragraph choices: 5"
        let result = parser.parse(correctParagraphs)
        
        // then
        
        // 2 paragraphs returned
        XCTAssertEqual(result.count, 2)
        
        // no errors printed out
        XCTAssertNil(mockConsole.lastLine?.count)
        
        // returned paragraphs contain correct data
        XCTAssertEqual(result[0].text, "foo bar ")
        XCTAssertEqual(result[0].choices, [4, 5, 8])
        XCTAssertEqual(result[1].text, "second paragraph ")
        XCTAssertEqual(result[1].choices, [5])
    }
    
    func testThatIfOneParagraphDoesntParseOthersStillCan() {
        // given
        let faultyAndCorrectParagraphs = "id: x incorrect paragraph choices: 4, 5, 8 --- next --- id: 8 correct paragraph choices: 5"
        let result = parser.parse(faultyAndCorrectParagraphs)
        
        // then
        
        // 1 paragraphs returned
        XCTAssertEqual(result.count, 1)
        
        // parsing errors printed out
        XCTAssertNotNil(mockConsole.lastLine?.count)
        
        // returned paragraphs contain correct data
        XCTAssertEqual(result[0].text, "correct paragraph ")
        XCTAssertEqual(result[0].choices, [5])
    }
}
