import Foundation

protocol IOWriter {
    func print(_ line :String)
}

extension IOWriter {
    
    /** default implementation */
    func print(_ line :String) {
        Swift.print(line)
    }
}
