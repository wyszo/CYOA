import Foundation

class MockIO: IOReader {
    
    private let simulatedInput = ["2", "5"]
    private let delay: UInt32 = 1
    
    private var currentInput = 0
    private let ioWriter: IOWriter
    
    init(ioWriter: IOWriter) {
        self.ioWriter = ioWriter
    }
    
    func readLine() -> String? {
        return readMockInput()
    }
}

extension MockIO {
    fileprivate func readMockInput() -> String? {
        if currentInput < simulatedInput.endIndex {
            let line = simulatedInput[currentInput]
            currentInput += 1
            
            if delay > 0 {
                sleep(delay)
            }
            print(line)
            return line
        } else {
            return nil
        }
    }
}
