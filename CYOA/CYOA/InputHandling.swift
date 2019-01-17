import Foundation

/**
 Only works in Command Line
 */
fileprivate func readStdin() -> String? {
    return readLine()
}

/**
 Alternative implementation, doesn't seem to change anything
 */
fileprivate func readKeyboardInput() -> String? {
    let keyboard = FileHandle.standardInput
    let inputData = keyboard.availableData
    
    return NSString(data: inputData, encoding: String.Encoding.utf8.rawValue) as String?
}

// [ ] can I make this static inside the method itself??
fileprivate var currentSimulatedLine = 0
fileprivate let simulatedInput = ["2", "5"]
fileprivate let simulatedInputDelay: UInt32 = 1

fileprivate func readSimulatedKeyboardInput() -> String? {
    if currentSimulatedLine < simulatedInput.endIndex {
        let line = simulatedInput[currentSimulatedLine]
        currentSimulatedLine += 1
        
        if simulatedInputDelay > 0 {
            sleep(simulatedInputDelay)
        }
        print(line)
        return line
    } else {
        return nil
    }
}

/**
 A wrapper function, so that we can simulate a choices made by a computer
 */
public func readInput() -> String? {
    // return readStdin()
    // return readKeyboardInput()
    
    return readSimulatedKeyboardInput()
}
