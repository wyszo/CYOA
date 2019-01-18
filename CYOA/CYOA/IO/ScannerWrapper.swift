import Foundation

class ScannerWrapper {
    private let string: String
    private let scanner: Scanner
    
    init(string: String) {
        self.string = string
        self.scanner = Scanner(string: string)
    }
    
    func scan(upTo: String, consumingDelimiter: Bool = false) -> String {
        var scannedString: NSString?
        
        scanner.scanUpTo(upTo, into: &scannedString)
        
        if consumingDelimiter {
            var scannedDelimiter: NSString?
            scanner.scanString(upTo, into: &scannedDelimiter)
        }
        return (scannedString as String?) ?? ""
    }
    
    func scanTillEnd() -> String {
        return scan(upTo: "")
    }
    
    func scanInt() throws -> Int {
        var id: Int = 0
        if scanner.scanInt(&id) == false {
            throw ScanningError.notANumber
        }
        return id
    }
    
    public enum ScanningError: Error {
        case notANumber
    }
}
