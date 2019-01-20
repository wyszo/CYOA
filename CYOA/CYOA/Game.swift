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
        
        let adventureReader = AdventureReader(ioWriter: ioWriter)
        let paragraphs = adventureReader.loadAdventure()
        
        let paragraphWalker = ParagraphWalker(paragraphs: paragraphs, ioReader: ioReader, ioWriter: ioWriter)
        paragraphWalker.start()
    }
}

fileprivate extension Game {
    
    func printGameIntro() {
        ioWriter.print(Strings.gameIntro)
    }
    
    func readAnyKey() {
        _ = ioReader.readLine()
    }
}
