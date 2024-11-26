import SwiftUI

struct TalkAvatar: View {
    var imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
    var body: some View {
        VStack{
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(.blue, lineWidth: 1))
            Text("にこ")
                .font(.caption2)
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    TalkAvatar(imageName: "nico11")
}
