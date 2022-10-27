import SwiftUI

struct PlayerModel {
    var name: String = "Gracz"
    var points: Int = 0
    var setPoints: Int = 0
    var allPoints: Int = 0
    var serveFirst: Bool
    var needsToWinSet: Int = 11
    @AppStorage("winSet") var winSet: String = "11"
    @EnvironmentObject var mainViewModel: MainViewModel

    
    mutating func scorePoint(op: inout PlayerModel) {
        points += 1
        allPoints += 1
        if points == (Int(winSet) ?? 11) {
            setPoints += 1
            points = 0
            serveFirst = false
            op.points = 0
            op.serveFirst = true
        }
    }
    
    mutating func undoScorePoint() {
        if points > 0 {
            points -= 1
            allPoints -= 1
        }
    }
}
