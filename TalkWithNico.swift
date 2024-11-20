//
//  talkWithNico.swift
//  nico
//
//  Created by Takashi Matsui on 2024/11/11.
//

import SwiftUI
import AVFoundation
import GoogleGenerativeAI

struct TalkWithNico: View {
    let model = GenerativeModel(name: "gemini-1.5-flash-002", apiKey: APIKey.default)
    
    @State private var Prompt = ""
    @State private var prePrompt = "メスのマルチーズの「にこ」として回答してください。"
    @State private var Respons = ""
    @State private var isLoading = false
    
    @FocusState private var focus:Bool
    
    @EnvironmentObject var navi: NaviModel
    
    var body: some View {
        ZStack {
            Image("nico14")
                .resizable()
                .cornerRadius(20)
                .scaledToFit()
            VStack {
                Spacer()
                
                ScrollView {
                    Text(Respons)
                        .font(.body)
                        .foregroundColor(.blue)
                        .border(Color.pink, width: 0)
                }
                
                
                HStack {
                    TextField("ここに入力", text: $Prompt)
                        .textFieldStyle(.roundedBorder)
                        .focused($focus)
                    Button(action: {
                        focus = false
                        if (Prompt != ""){
                            do{
                                nicoPlayer = try AVAudioPlayer(data: barkData)
                                nicoPlayer.play()
                            }catch{
                                print("音の再生に失敗しました。")
                            }
                            generateRespons()
                        }
                    }){
                        Image(systemName: "square.and.arrow.up")
                            .frame(width: 40, height: 40)
                            .background(.cyan)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding()
                
                Text("なんでも話して")
                    .font(.title3)
                    .foregroundColor(.blue)
                
                Button{
//                    print(navi.screens.count)
//                    navi.screens.removeLast(navi.screens.count)
                    navi.screens.removeAll()
                }label:{
                    Image(systemName:"dog")
                    Text("メニューに戻る")
                        .foregroundColor(.red)
                }
                .padding()
                
            }
            
            if isLoading {
                Color.orange.opacity(0.1)
                ProgressView()
            }
        }
        .onTapGesture {
            focus = false
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func generateRespons() {
        isLoading = true
        Respons = ""
        
        Task {
            do {
                let result = try await
                model.generateContent(prePrompt + Prompt)
                isLoading = false
                Respons = result.text ?? "No Respons found"
                Prompt = ""
            } catch {
                Respons = "ごめんなさい、イヌ翻訳機の調子が悪いみたいです\n \(error.localizedDescription)"
                isLoading = false
                Prompt = ""
            }
        }
    }
}

#Preview {
    TalkWithNico().environmentObject(NaviModel())
}
