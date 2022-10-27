import SwiftUI

struct PlayerView: View {
    let hh = UIScreen.main.bounds.height
    let playerBackgroundColor: Color
    @Binding var player: PlayerModel
    @Binding var otherPlayer: PlayerModel
    @EnvironmentObject var mainViewModel: MainViewModel
    
    
    init(_ playerBackgroundColor: Color, player: Binding<PlayerModel>, otherPlayer: Binding<PlayerModel>) {
        self.playerBackgroundColor = playerBackgroundColor
        self._player = player
        self._otherPlayer = otherPlayer
    }
    
    var body: some View {
        ZStack {
            playerBackgroundColor
                .cornerRadius(15)
            
            // text content
            VStack{
                nameLabel
                pointsLabel
                setPointsLabel
                allPointsLabel
            }
        }
        .onTapGesture {
            player.scorePoint(op: &otherPlayer)
        }
        .gesture(
            MagnificationGesture()
                .onEnded{ _ in
                    player.undoScorePoint()
                }
        )
    }
}


//MARK: LABELS Extension

extension PlayerView {
    
    var nameLabel: some View {
        Text(String(player.name))
            .font(.system(size: hh/20))
            .fontWeight(.ultraLight)
    }
    
    var pointsLabel: some View {
        Text(String(player.points))
            .font(.system(size: hh/6))
            .fontWeight(.bold)
    }
    var setPointsLabel: some View {
        Text(String(player.setPoints))
            .font(.system(size: hh/15))
            .fontWeight(.light)
    }
    
    var allPointsLabel: some View {
        Text(String(player.allPoints))
            .font(.system(size: hh/40))
            .fontWeight(.thin)
    }

    var serveLabel: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: "s.circle")
                    .resizable()
                    .frame(maxWidth: hh/10, maxHeight: hh/10, alignment: .leading)
                    .scaledToFit()
                    .padding()
                Spacer()
            }
            .padding()
        }
    }    
}
