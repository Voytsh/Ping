import SwiftUI

struct MainView: View {
    let hh = UIScreen.main.bounds.height
    let ww = UIScreen.main.bounds.width
    var startsTheGame: Bool = false
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @State var showSettings: Bool = false
    @State var showInfoAlert: Bool = false
    @AppStorage("winSet") var winSet: String = "11"

    
        var body: some View {
            ZStack{
                //background
                Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))
                .edgesIgnoringSafeArea(.all)
                
                //Text content
                VStack(spacing: 0){
                    //P1
                    ZStack{
                        PlayerView(Color("C1"), player: $mainViewModel.player1, otherPlayer: $mainViewModel.player2)
                            .padding(15)
                        getImage(mainViewModel.p1Serves()) // S icon telling if it's the player's turn to serve
                    }
                    
                    //settings&info
                    midSection
                    
                    //P2
                    ZStack{
                        PlayerView(Color("C2"), player: $mainViewModel.player2, otherPlayer: $mainViewModel.player1)
                            .padding(15)
                        getImage(!mainViewModel.p1Serves()) // S icon telling if it's the player's turn to serve
                    }
                }
            }
            .sheet(isPresented: $showSettings, content: {
                SettingsView(showSettings: $showSettings)
            })
        }
}
extension MainView {
    func getImage(_ isServing: Bool) -> some View {
        return Image(systemName: "s.circle")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: ww/9, maxHeight: hh/9)
            .padding(ww/8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .opacity(isServing ? 1 : 0)
    }
    
    var midSection: some View {
        HStack{
            Button(action: {
                showSettings.toggle()
            }, label: {
                Image(systemName: "gearshape")
                    .padding(.all, 2)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.9843137255, blue: 0, alpha: 1)))
            })
            .padding(.horizontal)
            
            Text("Set is played to \(winSet) points")
                .font(.footnote)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 0.9843137255, blue: 0, alpha: 1)))
            
            Button(action: {
                showInfoAlert.toggle()
            }, label: {
                Image(systemName: "info.circle")
                    .padding(.all, 2)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.9843137255, blue: 0, alpha: 1)))
            })
            .padding(.horizontal)
            .alert(isPresented: $showInfoAlert, content: {
                Alert(title: Text(""),
                      message: Text("Click on a player's tile to add their a point. \n\n Make a pinching or magnification gesture (with two fingers) to substract one point.").foregroundColor(.red)
                      )
            })
        }
    }
}
