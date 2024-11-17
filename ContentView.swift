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

struct ContentView: View {
    @StateObject var navi = NaviModel()
    @State var findNumber:Int = 1
    @State private var findOffsetX: CGFloat = -7
    @State private var findOffsetY: CGFloat = 0

    var body: some View {
        Section(header: Text("にこのアプリ")
            .font(.system(.title, design: .serif))
            .fontWeight(.black)
            .foregroundColor(.blue)
                ,footer: Text("© 2024 Takashi")
            .font(.footnote)
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
                        case .play:
                            PlayWithNico()
                        case .find:
                            FindNico(findNumber: $findNumber, findOffsetX: $findOffsetX, findOffsetY: $findOffsetY)  
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
