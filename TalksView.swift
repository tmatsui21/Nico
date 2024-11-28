import SwiftUI
import SwiftData

struct TalksView: View {
    @Query(sort: \Talk.date, order: .reverse) private var talks: [Talk]
    @Environment(\.modelContext) private var context
    
    @State private var isShowAlert = false
    @State private var isShowDialog = false
    @State private var delTalk: Talk?

    @EnvironmentObject var navi: NaviModel
    
    var body: some View {
        VStack {
            ScrollView{
                VStack (alignment: .leading){
                    ForEach(talks){talk in
                        Spacer()
                        HStack {
                            Text(talk.date.formatted(.dateTime.year().month().day().hour().minute()))
                            Spacer()
                            Button("削除"){
                                delTalk = talk
                                isShowDialog.toggle()
                            }
                            .font(.subheadline)
                            .confirmationDialog("会話をひとつ削除しますか?", isPresented: $isShowDialog, titleVisibility: .visible) {
                                Button("削除する", role: .destructive) {
                                    context.delete(delTalk!)
                                }
                            }
                            Image(systemName: "minus.circle.fill").foregroundColor(.orange)
                        }
                        .padding()
                        HStack {
                            Spacer()
                            Text(talk.prompt)
                                .padding(10)
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .cornerRadius(20)
                            VStack{
                                Image(systemName: "person")
                                Text("あなた").font(.caption2).foregroundColor(.gray)
                            }
                        }
                        .padding()
                        HStack {
                            TalkAvatar(imageName: "nico11")
                            Text(talk.respons)
                                .bold()
                                .padding(10)
                                .foregroundColor(Color.white)
                                .background(.cyan)
                                .cornerRadius(20)
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
//            .task {
//                context.insert(Talk(prompt: "テストテスト", respons: "答えのテストだよ答えのテストだよ"))
//                context.insert(Talk(prompt: "テストテスト２", respons: "答えのテストだよ答えのテストだよ"))
//                context.insert(Talk(prompt: "テストテスト３", respons: "答えのテストだよ答えのテストだよ"))
//                context.insert(Talk(prompt: "テストテスト４", respons: "答えのテストだよ答えのテストだよ"))
//            }
            HStack{
                Spacer()
                if (!talks.isEmpty){
                    Button("全て削除する"){
                        isShowAlert.toggle()
                    }
                    .font(.subheadline)
                    .alert("全削除", isPresented: $isShowAlert){
                        Button ("はい全て削除します", role: .destructive){
                            for talk in talks {
                                context.delete(talk)
                            }
                        }
                    } message: {
                        Text("本当に全て削除しますか")
                    }
                    Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.red)
                }
            }.padding()
            
            Button{
                print(navi.screens.count)
                navi.screens.removeLast()
            }label:{
                Image(systemName:"dog")
                Text("会話に戻る")
                    .foregroundColor(.blue)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TalksView()
        .environmentObject(NaviModel())
        .modelContainer(for: Talk.self, inMemory: true)
}
