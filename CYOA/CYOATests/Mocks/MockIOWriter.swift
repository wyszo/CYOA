@testable import CYOA

class MockIOWriter: IOWriter {
    var lastLine: String?
    
    func print(_ line :String) {
        lastLine = line
    }
}
