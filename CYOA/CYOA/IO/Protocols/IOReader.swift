import Foundation

protocol IOReader {
    func readLine() -> String?
}

extension IOReader {
    
    /** default implementation */
    func readLine() -> String? {
        return Swift.readLine()
    }
}
