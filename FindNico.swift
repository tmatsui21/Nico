//
//  FindNico.swift
//  MyFirstApp
//
//  Created by Takashi Matsui on 2024/11/09.
//

import SwiftUI
import AVFoundation

struct FindNico: View {
    @State private var isShowCorrectView = false
    @State private var isShowInCorrectView = false
    @State private var location = CGPoint()
    @EnvironmentObject var navi: NaviModel
    
    @Binding var findNicoScreen: FindNicoScreen
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image("ペット博\(findNicoScreen.findNumber)")
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
                    //                    AudioServicesPlaySystemSound(1054)
                    //                    print("Button Clicked")
                }) {
                    Text("当たり位置")
                        .padding()
                        .frame(width: 35,height: 67)
                        .border(.clear, width: 5)
                        .background(.clear)
                        .foregroundColor(.clear)
                        .cornerRadius(10)
                }
                .offset(x: findNicoScreen.findOffsetX, y: findNicoScreen.findOffsetY)
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
            //                        .sheet(isPresented: $isShowCorrectView) {
            //                            correct()
            //                        }
            .sheet(isPresented: $isShowInCorrectView) {
                incorrect()
            }
            
            Text("問題\(findNicoScreen.findNumber): にこはどこでしょう？")
                .foregroundColor(.purple)
            Spacer()
            
            HStack{
                if (findNicoScreen.findNumber != 1){
                    Button("問題1🔍") {
                        findNicoScreen.findNumber = 1
                        findNicoScreen.findOffsetX = -7
                        findNicoScreen.findOffsetY = 0
                        navi.screens.append(.find)
                    }
                }
                if (findNicoScreen.findNumber != 2){
                    Button("問題2🔍") {
                        findNicoScreen.findNumber = 2
                        findNicoScreen.findOffsetX = -3
                        findNicoScreen.findOffsetY = 20
                        navi.screens.append(.find)
                    }
                }
                if (findNicoScreen.findNumber != 3){
                    Button("問題3🔍") {
                        findNicoScreen.findNumber = 3
                        findNicoScreen.findOffsetX = -45
                        findNicoScreen.findOffsetY = 10
                        navi.screens.append(.find)
                    }
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
            
            .navigationBarBackButtonHidden(true)
            
        }
    }
}

#Preview {
    FindNico(findNicoScreen: .constant(FindNicoScreen(findNumber: 1, findOffsetX: -7, findOffsetY: 0))).environmentObject(NaviModel())
}
