import SwiftUI

struct SettingsView: View {
    let hh = UIScreen.main.bounds.height
    @State var p1TF: String = ""
    @State var p2TF: String = ""
    @Binding var showSettings: Bool
    @EnvironmentObject var mainViewModel: MainViewModel
    
    let setTo: [SetTo] = [SetTo("3"), SetTo("5"), SetTo("7"), SetTo("11"), SetTo("15"), SetTo("25"), SetTo("50"), SetTo("100")]
    let gameTo: [GameTo] = [GameTo("1"), GameTo("2"), GameTo("3"), GameTo("5")]

    @State var selectSetTo: String = "11"
    @State var setToWasChange: Bool = false
    @State var selectGameTo: String = "5"
    
    @State var setToLabel: String = "11"
    @AppStorage("winSet") var winSet = "11"
    @State var watcher: Int = -1
    
//MARK: BODY
    
    var body: some View {
        ZStack{
            //background
            Color("C3-2")
                .edgesIgnoringSafeArea(.all)
            
            Color("C3")
                .cornerRadius(25)
                .padding()
            
            VStack(alignment: .center, spacing: 5.0) {
                buttonLayer
                    .padding(.vertical)
                tfLayer
                    .padding(.vertical)
                Spacer()
                HStack(alignment: .center, spacing: 5.0) {
                    Text("Play set to: ")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("C3-1"))
                    pickersLayer
                        .padding(.vertical)
                }
                Text("If you change this setting, the current score will be lost!")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("C3-1"))
                Spacer()
                
            }
            .padding(50)
        }
    }
}


extension SettingsView {
    

    //MARK: METHODS
    
    func canSave() -> Bool {
        if p1TF.count > 0 || p2TF.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func saveChanges() {
        if canSave() {
            if p1TF.count > 0 {
                mainViewModel.player1.name = p1TF
                p1TF = ""
                //g1 = p1TF
            }
            if p2TF.count > 0 {
                mainViewModel.player2.name = p2TF
                p2TF = ""
            }
            mainViewModel.player1.needsToWinSet = Int(selectSetTo) ?? 11
            mainViewModel.player2.needsToWinSet = Int(selectSetTo) ?? 11
        }
    }
    
    //MARK: LAYERS
    
    var buttonLayer: some View {
        HStack {
            Button(action: {
                showSettings = false
            }, label: {
                Text("Back to game")
                    .padding()
                    .foregroundColor(Color("C3"))
                    .font(.subheadline)
                    .background(Color("C3-1"))
                    .cornerRadius(15)
                    
            })
            
            Spacer()
            
            Button(action: {
                    saveChanges()
            }, label: {
                Text("Save Names")
                    .padding()
                    .foregroundColor(canSave() ? Color("C3-1") : Color.gray)
                    .font(.subheadline)
                    .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(canSave() ? Color("C3-1") : Color.gray, lineWidth: 1)
                        )
            })
            .disabled(!canSave())
        }
    }
    
    var tfLayer: some View {
        VStack(spacing: 15) {
            TextField("New Player1 Name", text: $p1TF)
                .padding()
                .background(Color.gray.opacity(0.3)).cornerRadius(15)
                .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("C1"), lineWidth: 3)
                    )
                .multilineTextAlignment(.center)
                .padding(.vertical, 5)
            
            TextField("New Player2 Name", text: $p2TF)
                .padding()
                .background(Color.gray.opacity(0.3)).cornerRadius(15)
                .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("C2"), lineWidth: 3)
                )
                .multilineTextAlignment(.center)
                .padding(.vertical, 5)
        }
    }
    
    var pickersLayer: some View {
        VStack{
            Picker(selection: $selectSetTo,
                   label:
                    HStack{
                        Text("Play set to \(setToLabel) points")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color("C3-1"))
                            .font(.headline)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("C3-1"), lineWidth: 1)
                                )
                    }
                   ,
                   content: {
                    ForEach(setTo) {num in
                        Text(String(num.points))
                            .tag(String(num.points))
                    }
                   }
            )
            .pickerStyle(MenuPickerStyle())
            .onChange(of: selectSetTo, perform: { _ in
                winSet = selectSetTo
                setToLabel = selectSetTo
                if watcher >= 0{
                    mainViewModel.player1.points = 0
                    mainViewModel.player2.points = 0
                    mainViewModel.player1.setPoints = 0
                    mainViewModel.player2.setPoints = 0
                    mainViewModel.player1.allPoints = 0
                    mainViewModel.player2.allPoints = 0
                }
                watcher += 1
            })
            .padding(.vertical)
        }
        .onAppear(perform: {
            setToLabel = winSet
            selectSetTo = winSet
        })
    }
}

struct SetTo: Identifiable {
    let id = UUID()
    let points: String
    
    init(_ points: String) {
        self.points = points
    }
}

struct GameTo: Identifiable {
    let id = UUID()
    let points: String
    
    init(_ points: String) {
        self.points = points
    }
}
