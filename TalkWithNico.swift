//
//  talkWithNico.swift
//  nico
//
//  Created by Takashi Matsui on 2024/11/11.
//

import SwiftUI
import AVFoundation
import GoogleGenerativeAI
import SwiftData

struct TalkWithNico: View {
    let model = GenerativeModel(name: "gemini-1.5-flash-002", apiKey: APIKey.default)
    
    @State private var prompt = ""
    @State private var prePrompt = "メスのマルチーズの「にこ」として回答してください。人間のお母さん（ママではない）とお父さん（パパではない）と女性の綾香(あやちゃん)と住んでいます。家族みんなが大好きです。兄弟のことは話さないでください。"
    @State private var tempPrompt = ""
    @State private var respons = ""
    @State private var isLoading = false
    
    @FocusState private var focus:Bool
    
    @EnvironmentObject var navi: NaviModel
    
    @Query private var talks: [Talk]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        ZStack {
            Image("nico6")
                .resizable()
                .cornerRadius(20)
                .scaledToFit()
            VStack {
                Spacer()
                
                ScrollView {
                    Text(respons)
                        .font(.body)
                        .foregroundColor(.blue)
                        .border(Color.pink, width: 0)
                }
                
                HStack {
                    Image(systemName: "message")
                    TextField("ここに入力してね", text: $prompt)
                        .textFieldStyle(.roundedBorder)
                        .focused($focus)
                    Button(action: {
                        focus = false
                        if (prompt != ""){
                            do{
                                nicoPlayer = try AVAudioPlayer(data: barkData)
                                nicoPlayer.play()
                            }catch{
                                print("音の再生に失敗しました。")
                            }
                            generateRespons()
                        }
                    }){
                        VStack {
                            Image(systemName: "square.and.arrow.up")
                                .frame(width: 30, height: 30)
                                .background(.cyan)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            Text("決定").font(.caption2)
                        }
                    }
                }
                .padding()

                HStack {
                    if (respons != ""){
                        Button{
                            context.insert(Talk(prompt: tempPrompt, respons: respons))
                            respons = ""
                        }label: {
                            HStack{
                                Image(systemName: "square.and.arrow.down")
                                Text("会話を保存する")
                            }
                        }
                        .font(.footnote)
                        .padding()
                    }
                    if (!talks.isEmpty){
                        Button {
                            navi.screens.append(.talks)
                        }label: {
                            HStack{
                                Text("保存した会話をみる").font(.footnote)
                                Image(systemName: "text.bubble")
                            }
                        }
                    }
                }
                
                Button{
                    navi.screens.removeAll()
                }label: {
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
        respons = ""
        
        Task {
            do {
                let result = try await
                model.generateContent(prePrompt + prompt)
                isLoading = false
                respons = result.text ?? "No Respons found"
                tempPrompt = prompt
                prompt = ""
            } catch {
                respons = "ごめんなさい、イヌ翻訳機の調子が悪いみたいです\n \(error.localizedDescription)"
                isLoading = false
                prompt = ""
            }
        }
    }
}

#Preview {
    TalkWithNico()
        .environmentObject(NaviModel())
        .modelContainer(for: Talk.self, inMemory: true)
}
