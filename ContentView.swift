//
//  ContentView.swift
//  MyFirstApp
//
//  Created by Takashi Matsui on 2024/11/08.
//

import SwiftUI
import AVFoundation

let barkData = NSDataAsset(name: "わん1")!.data
let barkData2 = NSDataAsset(name: "わん2")!.data
let cryingData = NSDataAsset(name: "きゅーん1")!.data
var nicoPlayer:AVAudioPlayer!

enum FindNicoScreenType: Int {
    case Q1 = 1, Q2, Q3
}

struct FindNicoScreen {
    var findNumber: Int = FindNicoScreenType.Q1.rawValue
    var findOffsetX: CGFloat = -7
    var findOffsetY: CGFloat = 0
}

struct ContentView: View {
    @StateObject var navi = NaviModel()
    @State private var findNicoScreen = FindNicoScreen()

    var body: some View {
        Section(header: Text("にこのアプリ")
            .font(.system(.title, design: .serif))
            .fontWeight(.black)
            .foregroundColor(.blue)
        ) {
            NavigationStack (path: $navi.screens){
                ZStack {
                    Image("ネモフィラ")
                        .resizable()
                        .cornerRadius(20)
                        .scaledToFit()
                    VStack{
                        Button("🐾にこと遊ぶ🐾") {
                            navi.screens.append(.play)
                        }
                        .font(.system(.title, design: .rounded))
                            .bold().foregroundColor(.cyan)
                            .padding().background().cornerRadius(50)
                        Button("🐾にこを探す🔍") {
                            navi.screens.append(.find)
                        }
                        .font(.system(.title, design: .rounded))
                        .bold().foregroundColor(.cyan)
                        .padding().background().cornerRadius(50)
                        Button("🐾にこと話す🗣️") {
                            navi.screens.append(.talk)
                        }
                        .font(.system(.title, design: .rounded))
                        .bold().foregroundColor(.cyan)
                        .padding().background().cornerRadius(50)
                    }
                    .navigationDestination (for: NaviModel.ScreenKey.self) { value in
                        switch value {
                        case .talks:
                            TalksView()
                        case .play:
                            PlayWithNico()
                        case .find:
                            FindNico(findNicoScreen: $findNicoScreen)  
                        case .talk:
                            TalkWithNico()
                        }
                    }
                }
            }
            .environmentObject(navi)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
