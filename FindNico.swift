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
    @Binding var findNumber: Int
    @Binding var findOffsetX: CGFloat
    @Binding var findOffsetY: CGFloat
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image("ペット博\(findNumber)")
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
                        .border(.red, width: 5)
                        .background(.clear)
                        .foregroundColor(.clear)
                        .cornerRadius(10)
                }
                .offset(x: findOffsetX, y: findOffsetY)
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
            
            Text("問題\(findNumber): にこはどこでしょう？")
                .foregroundColor(.purple)
            Spacer()
            
            HStack{
                if (findNumber != 1){
                    Button("問題1🔍") {
                        findNumber = 1
                        findOffsetX = -7
                        findOffsetY = 0
                        navi.screens.append(.find)
                    }
                }
                if (findNumber != 2){
                    Button("問題2🔍") {
                        findNumber = 2
                        findOffsetX = -3
                        findOffsetY = 20
                        navi.screens.append(.find)
                    }
                }
                if (findNumber != 3){
                    Button("問題3🔍") {
                        findNumber = 3
                        findOffsetX = -45
                        findOffsetY = 10
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
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    FindNico(findNumber: .constant(1), findOffsetX: .constant(-7), findOffsetY: .constant(0)).environmentObject(NaviModel())
}
