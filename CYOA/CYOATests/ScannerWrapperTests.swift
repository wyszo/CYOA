import XCTest
@testable import CYOA

class CYOATests: XCTestCase {
    
    var scanner: ScannerWrapper!
    
    override func setUp() {
    }
    
    override func tearDown() {
        scanner = nil
    }
    
    func testScannerCreationWithNormalStringSucceeds() {
        // given
        scanner = ScannerWrapper(string: "testString")
        
        // then
        XCTAssertNotNil(scanner)
    }
    
    func testScannerCreationWithEmptyStringSucceeds() {
        // given
        scanner = ScannerWrapper(string: "")
        
        // then
        XCTAssertNotNil(scanner)
    }
    
    func testScansStringCorrectly() {
        // given
        scanner = ScannerWrapper(string: "foo bar")
        
        // when
        let foo = scanner.scan(upTo: " ")
        let bar = scanner.scan(upTo: "")
        
        // then
        XCTAssertEqual(foo, "foo")
        XCTAssertEqual(bar, "bar")
    }
    
    func testScanPrefix() {
        // given
        scanner = ScannerWrapper(string: "foo")
        
        // when
        let foo = scanner.scan(upTo: "foo")
        
        // then
        XCTAssertEqual(foo, "")
    }
    
    func testScanConsumingDelimiter() {
        // given
        scanner = ScannerWrapper(string: "tag bar")
        
        // when
        let consumedTag = scanner.scan(upTo: "tag", consumingDelimiter: true)
        let bar = scanner.scanTillEnd()
        
        // then
        XCTAssertEqual(consumedTag, "")
        XCTAssertEqual(bar, "bar")
    }
    
    func testScanIntCorrectly() {
        // given
        scanner = ScannerWrapper(string: "5")
        
        // when
        let number = try? scanner.scanInt()
        
        // then
        XCTAssertEqual(number, Int(5))
    }
    
    func testScanIntWithWhitespaces() {
        // given
        scanner = ScannerWrapper(string: " 5")
        
        // when
        let number = try? scanner.scanInt()
        
        // then
        XCTAssertEqual(number, Int(5))
    }
    
    func testThrowsOnIntScanningNotANumber() {
        // given
        scanner = ScannerWrapper(string: "<not a number>")
        
        // when trying to scan Int, then
        XCTAssertThrowsError( try scanner.scanInt() )
    }
    
    func testScanStringWithNumberCorrectly() {
        // given
        scanner = ScannerWrapper(string: "foo 5 bar")
        
        // when
        let foo = scanner.scan(upTo: " ")
        let number = try? scanner.scanInt()
        let bar = scanner.scan(upTo: "")
        
        // then
        XCTAssertEqual(foo, "foo")
        XCTAssertEqual(number, Int(5))
        XCTAssertEqual(bar, "bar")
    }
    
    func testScanTillEnd() {
        // given
        scanner = ScannerWrapper(string: "foo bar")
        
        // when
        let foo = scanner.scan(upTo: " ")
        let bar = scanner.scanTillEnd()
        
        // then
        XCTAssertEqual(foo, "foo")
        XCTAssertEqual(bar, "bar")
    }
}
