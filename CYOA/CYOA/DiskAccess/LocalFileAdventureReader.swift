import Foundation

// [ ] unit tests
final class LocalFileAdventureReader {
    let ioWriter: IOWriter
    
    init(ioWriter: IOWriter) {
        self.ioWriter = ioWriter
    }
    
    func loadAdventure() -> [Paragraph] {
        return adventureFromFile(named: Constants.fileName)
    }
    
    private struct Constants {
        static let fileName = "adventure.txt"
    }
}

fileprivate extension LocalFileAdventureReader {
    
    func adventureFromFile(named fileName: String) -> [Paragraph] {
        let parser = Parser(ioWriter: ioWriter)
        
        let adventurePath = FileManager.default.currentDirectoryPath + "/\(fileName)"
        
        if let string = try? String(contentsOfFile: adventurePath) {
            return parser.parse(string)
        } else {
            ioWriter.print("Parsing error! Can't find adventure file!")
        }
        return []
    }
}
