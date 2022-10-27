//
//  PingApp.swift
//  Ping
//
//  Created by Filip Wojcieszak on 11/07/2021.
//

import SwiftUI

@main
struct PingApp: App {
    
    @StateObject var mainViewModel : MainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup{
            MainView()
                .environmentObject(mainViewModel)
        }
    }
}
