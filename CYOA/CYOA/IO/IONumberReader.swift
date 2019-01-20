import Foundation

class IONumberReader {
    let ioReader: IOReader
    let ioWriter: IOWriter
    
    init(ioReader: IOReader, ioWriter: IOWriter) {
        self.ioReader = ioReader
        self.ioWriter = ioWriter
    }
    
    /**
     Returns a number selected by user eventually.
     In case of incorrect input, asks again.
     */
    func readNumber() -> Int {
        var choice: Int? = nil
        
        while choice == nil {
            if let line = ioReader.readLine() {
                if let intChoice = Int(line) {
                    choice = intChoice
                } else {
                    ioWriter.print("Not a number! Try again!")
                }
            }
        }
        return choice!
    }
    
    /**
     Reads numbers from user input only allowing to input specific ones
     */
    func readNumber(from: [Int]) -> Int {
        
        var number: Int = 0
        
        while(true) {
            number = readNumber()
            if from.contains(number) == true {
                break
            } else {
                ioWriter.print("You can't choose that path. Try again!")
            }
        }
        return number
    }
}
