//
//  incorrect.swift
//  MyFirstApp
//
//  Created by Takashi Matsui on 2024/11/09.
//

import SwiftUI

struct incorrect: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Image("不正解")
            .resizable()
            .cornerRadius(20)
            .scaledToFit()
        
        Text("残念😢不正解です")
            .font(.largeTitle)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    dismiss()
                }
            }
    }
}

#Preview {
    incorrect()
}
