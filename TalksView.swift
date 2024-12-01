import SwiftUI
import SwiftData

struct TalksView: View {
    @Query(sort: \Talk.date, order: .reverse) private var talks: [Talk]
    @Environment(\.modelContext) private var context
    
    @State private var isShowAlert = false
    @State private var isShowDialog = false
    @State private var delTalk: Talk?

    @EnvironmentObject var navi: NaviModel

    @State private var exportText = ""
    @State private var exportFile: Bool = false
    
    var body: some View {
        VStack {
            ScrollView{
                VStack (alignment: .leading){
                    ForEach(talks){talk in
                        Spacer()
                        HStack {
                            Text(talk.date.formatted(.dateTime.year().month().day().hour().minute()))
                            Spacer()
                            Button{
                                delTalk = talk
                                isShowDialog.toggle()
                            } label: {
                                HStack{
                                    Text("削除")
                                    Image(systemName: "minus.circle.fill").foregroundColor(.orange)
                                }
                            }
                            .font(.subheadline)
                            .confirmationDialog("会話をひとつ削除しますか?", isPresented: $isShowDialog, titleVisibility: .visible) {
                                Button("削除する", role: .destructive) {
                                    context.delete(delTalk!)
                                }
                            }
                        }
                        .padding()
                        HStack {
                            Spacer()
                            Text(talk.prompt)
                                .textSelection(.enabled)
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
                                .textSelection(.enabled)
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
                if (!talks.isEmpty){
                    Button {
                        for talk in talks {
                            exportText += "\(talk.date.formatted(.dateTime.year().month().day().hour().minute()))\n（あなた）" + talk.prompt + "\n（にこちゃん）" + talk.respons + "\n"
                        }
                        exportFile = true
                    }label: {
                        HStack{
                            Image(systemName: "square.and.arrow.up.circle")
                                .foregroundColor(.purple)
                            Text("会話をファイルに保存する")
                        }
                    }
                    .font(.caption)
                    .fileExporter(isPresented: $exportFile,
                                  document: TalkFileDocument(text: exportText),
                                  contentTypes: [.plainText],
                                  defaultFilename: "にことの会話.txt"
                    ) { result in
                        switch result {
                        case .success(let file):
                            print(file)
                        case .failure(let error):
                            print(error)
                        }
                    }
                    Spacer()
                    Button {
                        isShowAlert.toggle()
                    }label: {
                        HStack{
                            Text("全て削除する")
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                        }
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
                }
            }.padding()
            
            Button{
                print(navi.screens.count)
                navi.screens.removeLast()
            }label: {
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
