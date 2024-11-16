//
//  Screens.swift
//  nico
//
//  Created by Takashi Matsui on R 6/11/14.
//

import SwiftUI

final class NaviModel: ObservableObject {
    @MainActor @Published var screens: [ScreenKey] = []
    
    enum ScreenKey: Hashable{
        case play
        case find
        case find2
        case find3
        case talk
    }
}
