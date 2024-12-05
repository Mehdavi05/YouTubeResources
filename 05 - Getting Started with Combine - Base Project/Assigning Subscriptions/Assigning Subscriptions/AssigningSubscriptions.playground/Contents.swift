import UIKit
import Combine

final class LevelsManager {
    
    var level: Int = 0 {
        didSet {
            print("User's current level \(level)")
        }
    }
}

let lvlManager = LevelsManager()
let lvlRange = (1...100)
let cancelable = lvlRange
    .publisher
    .assign(to: \.level, on: lvlManager)
