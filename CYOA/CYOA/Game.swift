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
        
        // [ ] Write a paragraph walker that controls the game and takes user input to change displayed paragraph
        parseAdventureFromFile()
        let _ = readNumber()
    }
}

fileprivate extension Game {
    func parseAdventureFromFile() {
        let parser = Parser(ioWriter: ioWriter)
        
        // This will be a problem when trying to run this CLI utility using web repl, I'll have to host a file and access it online first
        let adventurePath = FileManager.default.currentDirectoryPath + "/adventure.txt"
        
        if let string = try? String(contentsOfFile: adventurePath) {
            _ = parser.parse(string)
        } else {
            ioWriter.print("Parsing error! Can't find adventure file!")
        }
    }
    
    func printGameIntro() {
        ioWriter.print(Strings.gameIntro)
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
