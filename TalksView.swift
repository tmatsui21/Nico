import SwiftUI
import SwiftData

struct TalksView: View {
    @Query(sort: \Talk.date) private var talks: [Talk]
    @Environment(\.modelContext) private var context
    
    @State var isShowAlert = false
    
    @State private var alertType: AlertType = .delete
    
    @EnvironmentObject var navi: NaviModel
    
    enum AlertType {
        case delete
        case clear
    }
    
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
                                alertType = .delete
                                isShowAlert.toggle()
                            }
                            .alert(isPresented: $isShowAlert){
                                switch alertType {
                                case .delete:
                                    return Alert(
                                        title: Text("本当に削除しますか？"),
                                        primaryButton: .cancel(Text("キャンセル")),
                                        secondaryButton: .destructive(Text("削除します。"),
                                                                      action: {
                                                                          context.delete(talk)
                                                                      })
                                    )
                                    
                                case .clear:
                                    return Alert(
                                        title: Text("本当に全て削除しますか？"),
                                        primaryButton: .cancel(Text("キャンセル")),
                                        secondaryButton: .destructive(Text("全て削除します。"),
                                                                      action: {
                                                                          for talk in talks {
                                                                              context.delete(talk)
                                                                          }
                                                                      })
                                    )
                                }
                            }
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
            Button("全て削除する"){
                if (!talks.isEmpty){
                    alertType = .clear
                    isShowAlert.toggle()
                }
            }
            .padding()
            Button{
                print(navi.screens.count)
                navi.screens.removeLast()
            }label:{
                Image(systemName:"dog")
                Text("会話に戻る")
                    .foregroundColor(.red)
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
