import Foundation

// [ ] unit tests
final class AdventureReader {
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

fileprivate extension AdventureReader {
    
    func adventureFromFile(named fileName: String) -> [Paragraph] {
        let parser = Parser(ioWriter: ioWriter)
        
        // This will be a problem when trying to run this CLI utility using web repl, I'll have to host a file and access it online first
        let adventurePath = FileManager.default.currentDirectoryPath + "/\(fileName)"
        
        if let string = try? String(contentsOfFile: adventurePath) {
            return parser.parse(string)
        } else {
            ioWriter.print("Parsing error! Can't find adventure file!")
        }
        return []
    }
}
