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
        askLocalOrRemoteAdventure()
    }
}

fileprivate extension Game {
    
    func runLocalAdventure() {
        let adventureReader = LocalFileAdventureReader(ioWriter: ioWriter)
        let paragraphs = adventureReader.loadAdventure()
        play(paragraphs: paragraphs)
    }
    
    func play(paragraphs: [Paragraph]) {
        let paragraphWalker = ParagraphWalker(paragraphs: paragraphs, ioReader: ioReader, ioWriter: ioWriter)
        paragraphWalker.start()
    }
    

    func parseAdventure(string: String) -> [Paragraph] {
        let parser = Parser(ioWriter: ioWriter)
        return parser.parse(string)
    }
    
    func printGameIntro() {
        ioWriter.print(Strings.gameIntro)
    }
    
    func askLocalOrRemoteAdventure() {

        ioWriter.print("")
        ioWriter.print(Strings.localOrRemoteChoice)
        
        let choice = ioReader.readLine()
        ioWriter.print("")
        
        if choice?.trimmingCharacters(in: .whitespacesAndNewlines) == Strings.remoteAdventureShortcut {
            askRemoteAdventureUrl()
        } else {
            runLocalAdventure()
        }
    }
    
    func readAnyKey() {
        _ = ioReader.readLine()
    }
}

fileprivate extension Game {

    // TODO: clean this up
    func askRemoteAdventureUrl() {
        var done = false
        
        while(done == false) {
            ioWriter.print("")
            ioWriter.print(Strings.askRemoteAdventureUrl)
            
            let result = ioReader.readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
            ioWriter.print("")
            
            if result?.count == 0 {
                askLocalOrRemoteAdventure()
                done = true
            } else if let result = result {
                if let url = URL(string: result) {
                    downloadAndRunRemoteAdventure(url: url)
                    done = true
                } else {
                    ioWriter.print(Strings.incorrectUrl)
                    done = true
                }
            }
        }
    }
    
    // TODO: clean this up
    func downloadAndRunRemoteAdventure(url: URL) {
        
        let downloader = RemoteFileDownloader(ioWriter: ioWriter)
        
        if let contents = downloader.downloadRemoteFileSynchronous(url: url) {
            let paragraphs = parseAdventure(string: contents)
            if paragraphs.count > 0 {
                ioWriter.print("Playing remote adventure now.\n")
                play(paragraphs: paragraphs)
            } else {
                ioWriter.print("Incorrect adventure or parser error - no paragraphs found\n")
                askRemoteAdventureUrl()
            }
        } else {
            ioWriter.print("Couldn't download the file: \(url)")
            askRemoteAdventureUrl()
        }
    }
    
}
