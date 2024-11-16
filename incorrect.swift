//
//  incorrect.swift
//  MyFirstApp
//
//  Created by Takashi Matsui on 2024/11/09.
//

import SwiftUI

struct incorrect: View {
    @Environment(\.dismiss) var dismiss
    @State private var timer: Timer?
    @State private var count: Int = 0
    
    var body: some View {
        Image("不正解")
            .resizable()
            .cornerRadius(20)
            .scaledToFit()
        
        Text("残念😢不正解です")
            .font(.largeTitle)
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    count += 1
//                    print("timer カウント")
                    if (count > 3) {
                        count = 0
                        timer?.invalidate()
                        dismiss()
                    }
                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
//                    timer?.invalidate()
//                    timer = nil
//                    dismiss()
//                }
//                
            }
        
    }
}

#Preview {
    incorrect()
}
