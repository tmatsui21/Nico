//
//  correct.swift
//  MyFirstApp
//
//  Created by Takashi Matsui on 2024/11/09.
//

import SwiftUI

struct correct: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Image("正解")
            .resizable()
            .cornerRadius(20)
            .scaledToFit()
        Text("正解です！")
            .font(.largeTitle)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    dismiss()
                }
            }
    }
}

#Preview {
    correct()
}
