import Foundation

final class Game {

    private let ioReader: IOReader
    private let ioWriter: IOWriter
    
    init(ioReader: IOReader = ConsoleIO(), ioWriter: IOWriter = ConsoleIO()) {
        self.ioReader = ioReader
        self.ioWriter = ioWriter
    }
    
    func start() {
        printIntro()
        let _ = readNumber()
    }
}

fileprivate extension Game {
    func printIntro() {
        let intro = """
            You’re having a dream you’re in one of those interactive fiction novels that lets you decide what happens in the story by flipping to different parts of the book. It’s great. It gives you the feeling that the choices you make really matter, unlike reality where you have no autonomy whatsoever.

            To continue, go to Entry [3].
            """
        
        print(intro)
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
}
