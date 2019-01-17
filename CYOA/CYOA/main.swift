// [ ] will this work on Linux? (probably?? do I need to know? I'll just use web based Swift REPL instead)
import Foundation


func main() {
    
    let consoleIO = ConsoleIO()
    let ioReader: IOReader = Settings.mockResponses ? MockIO(ioWriter: consoleIO) : consoleIO
    
    let game = Game(ioReader: ioReader, ioWriter: consoleIO)
    game.start()
}

main()
