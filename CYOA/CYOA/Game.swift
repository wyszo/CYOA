import Foundation

final class Game {

    private let ioReader: IOReader
    private let ioWriter: IOWriter
    
    init(ioReader: IOReader = ConsoleIO(), ioWriter: IOWriter = ConsoleIO()) {
        self.ioReader = ioReader
        self.ioWriter = ioWriter
    }
    
    func start() {
        printGameIntro()
        readAnyKey()
        
        printIntro()
        let _ = readNumber()
    }
}

fileprivate extension Game {
    func printGameIntro() {
        ioWriter.print(Strings.gameIntro)
    }

    func printIntro() {
        ioWriter.print(Strings.GameEntries.firstEntry)
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
    
    func readAnyKey() {
        _ = ioReader.readLine()
    }
}
