//
//  FindNico.swift
//  MyFirstApp
//
//  Created by Takashi Matsui on 2024/11/09.
//

import SwiftUI
import AVFoundation

struct FindNico2: View {
    @State private var isShowCorrectView = false
    @State private var isShowInCorrectView = false
    
    @State private var location = CGPoint()
    
    @EnvironmentObject var navi: NaviModel
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image("ペット博2")
                    .resizable()
                    .cornerRadius(20)
                    .scaledToFit()
                Button(action: {
                    isShowCorrectView = true
                    do{
                        nicoPlayer = try AVAudioPlayer(data: barkData2)
                        nicoPlayer.play()
                    }catch{
                        print("音の再生に失敗しました。")
                    }
                    //AudioServicesPlaySystemSound(1054)
                    //                    print("Button Clicked")
                }) {
                    Text("当たり位置")
                        .padding()
                        .frame(width: 47,height: 77)
                        .border(.clear, width: 5)
                        .background(.clear)
                        .foregroundColor(.clear)
                        .cornerRadius(10)
                }
                .offset(x: -3, y: 9)
                .sheet(isPresented: $isShowCorrectView) {
                    correct()
                }
            }
            .onTapGesture(coordinateSpace: .global) { location in
                isShowInCorrectView = true
                do{
                    nicoPlayer = try AVAudioPlayer(data: cryingData)
                    nicoPlayer.play()
                }catch{
                    print("音の再生に失敗しました。")
                }
                //                AudioServicesPlaySystemSound(1053)
            }
            .sheet(isPresented: $isShowInCorrectView) {
                incorrect()
            }
            
            Text("問題2: にこはどこでしょう？")
                .foregroundColor(.purple)
            Spacer()
            
            HStack{
                Button("問題1🔍") {
                    navi.screens.append(.find)
//                    print(navi.screens)
                }
                Button("問題3🔍") {
                    navi.screens.append(.find3)
//                    print(navi.screens)
                }
            }
            .padding()

            Button{
                navi.screens.removeAll()
            }label:{
                Image(systemName:"dog")
                Text("メニューに戻る")
                    .foregroundColor(.red)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview {
    FindNico2().environmentObject(NaviModel())
}
