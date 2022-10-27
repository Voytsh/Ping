import Foundation

class MainViewModel: ObservableObject {
    @Published var player1 = PlayerModel(name: "Player1", serveFirst: true)
    @Published var player2 = PlayerModel(name: "Player2", serveFirst: false)
    
    func p1Serves() -> Bool {
        let suma = player1.points + player2.points
        
        if player1.serveFirst {
            if suma % 4 == 0 || suma % 4 == 1 {
                return true
            } else {
                return false
            }
        } else {
            if suma % 4 == 0 || suma % 4 == 1 {
                return false
            } else {
                return true
            }
        }
    }
}
