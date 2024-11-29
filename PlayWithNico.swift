//
//  PlayWithNico.swift
//  MyFirstApp
//
//  Created by Takashi Matsui on 2024/11/08.
//

import SwiftUI
import AVFoundation

struct PlayWithNico: View {
    @State private var offset = CGSize.zero
    @State private var image = Image("nico")
    
    let maxImage = 20
    @State private var numBox: [Int] = []

    @EnvironmentObject var navi: NaviModel
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                image.resizable().scaledToFit().padding()
                ZStack {
                    Image("足跡2")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .offset(offset)
                }
                .onTapGesture {
                    do{
                        nicoPlayer = try AVAudioPlayer(data: barkData)
                        nicoPlayer.play()
                    }catch{
                        print("音の再生に失敗しました。")
                    }
                    if (numBox.count == 0){
                        numBox = randNum(max: maxImage - 1)
                    }
                    //                    print (numBox)
                    withAnimation(.easeInOut(duration: 0.7)){
                        //                        image = Image("nico\(Int.random(in: 0 ..< maxImage))")
                        image = Image("nico\(numBox.removeFirst())")
                    }
                    offset = CGSize(width: CGFloat.random(in: -100...100), height: CGFloat.random(in: -180...180))
                }
            }
            HStack{
                Spacer()
                Text("🐾を押してね")
                    .foregroundColor(.purple)
                Spacer()
                if (numBox.count > 0){
                    Text("\(maxImage-numBox.count)/\(maxImage)")
                }
                else {
                    Text("Clear!")
                }
            }
            .padding()
            Button{
                //                print(navi.screens.count)
                //                navi.screens.removeLast(navi.screens.count)
                navi.screens.removeAll()
            }label:{
                Image(systemName:"dog")
                Text("遊びを終わる")
                    .foregroundColor(.red)
            }
        }
        .navigationBarBackButtonHidden(true)
        .task{
            numBox = randNum(max: maxImage - 1)
        }
    }
    
    private func randNum(max: Int) -> [Int]{
        let nums = [Int](0 ... max)
        return(nums.shuffled())
    }
}

#Preview {
    PlayWithNico().environmentObject(NaviModel())
}
