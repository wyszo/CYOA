import Foundation

class Parser {
    private let ioWriter: IOWriter
    
    init(ioWriter: IOWriter) {
        self.ioWriter = ioWriter
    }
    
    func parse(_ string: String) -> [Paragraph] {
        
        var results: [Paragraph] = []
        
        let paragraphs = string.components(separatedBy: Constants.paragraphSeparator)
        for (index, element) in paragraphs.enumerated() {
            if let paragraph = parse(paragraph: element, paragraphNumber: index) {
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
    
    func parse(paragraph: String, paragraphNumber: Int) -> Paragraph? {
        let scanner = ScannerWrapper(string: paragraph)
        
        _ = scanner.scan(upTo: "id:", consumingDelimiter: true)
        let id = try? scanner.scanInt()
        if id == nil {
            printError("Missing 'id:' clause in paragraph #\(paragraphNumber)")
            return nil
        }
        
        let text = scanner.scan(upTo: "choices:", consumingDelimiter: true).trimmingWhitespaceAtTheEnd()
        let allChoices = scanner.scanTillEnd()
        
        // TODO: this should be extracted somewhere, to some unit-testable utility!
        let choices = allChoices.components(separatedBy: ",").map { $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }.compactMap { Int($0) }
        
        if choices.count == 0 {
            printError("Missing 'choices:' clause in paragraph \(id ?? -1) (#\(paragraphNumber)")
            return nil
        }
        
        return Paragraph(text: text, choices: choices)
    }
}

fileprivate extension String {
    func trimmingWhitespaceAtTheEnd() -> String {
        return replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
    }
}
