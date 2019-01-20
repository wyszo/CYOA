import Foundation

// [ ] Unit tests
class ParagraphWalker {
    let paragraphs: [Paragraph]
    let ioWriter: IOWriter
    let numberReader: IONumberReader
    
    init(paragraphs: [Paragraph], ioReader: IOReader, ioWriter: IOWriter) {
        self.paragraphs = paragraphs
        self.ioWriter = ioWriter
        self.numberReader = IONumberReader(ioReader: ioReader, ioWriter: ioWriter)
    }
    
    func start() {
        var nextParagraph = 0
        
        while(true) {
            nextParagraph = playParagraph(number: nextParagraph)
        }
    }
}

fileprivate extension ParagraphWalker {
    /**
     Prints out current paragraph
     Returns next paragraph to play
     */
    func playParagraph(number: Int) -> Int {
        let paragraph = paragraphs[number]
        ioWriter.print(paragraph.text)
        let next = numberReader.readNumber(from: paragraph.choices)
        return next
    }
}
