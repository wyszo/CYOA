import Foundation

class Parser {
    private let ioWriter: IOWriter
    
    init(ioWriter: IOWriter) {
        self.ioWriter = ioWriter
    }
    
    func parse(_ string: String) -> [Paragraph] {
        
        var results: [Paragraph] = []
        
        string.components(separatedBy: Constants.paragraphSeparator).forEach {
            if let paragraph = parse(paragraph: $0) {
                results.append(paragraph)
            }
        }
        return results
    }
    
    private struct Constants {
        static let paragraphSeparator = "--- next ---"
    }
}

fileprivate extension Parser {
    func printError(_ string: String) {
        ioWriter.print("Parsing Error! " + string)
    }
    
    func parse(paragraph: String) -> Paragraph? {
        let scanner = ScannerWrapper(string: paragraph)
        
        _ = scanner.scan(upTo: "id:", consumingDelimiter: true)
        let id = try? scanner.scanInt()
        if id == nil {
            printError("Missing 'id:' clause in paragraph #[?]")
            return nil
        }
        
        let text = scanner.scan(upTo: "choices:", consumingDelimiter: true)
        let allChoices = scanner.scanTillEnd()
        
        // TODO: this should be extracted somewhere, to some unit-testable utility!
        let choices = allChoices.components(separatedBy: ",").map { $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }.compactMap { Int($0) }
        
        if choices.count == 0 {
            printError("Missing 'choices:' clause in paragraph ?")
            return nil
        }
        
        return Paragraph(text: text, choices: choices)
    }
}
