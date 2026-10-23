//
//  ContentView.swift
//  WeSplit
//
//  Created by gavin ward on 10/23/26.
//

import SwiftUI

struct ContentView: View {
   @State private var tapCount = 0
    

    var body: some View {
        Button("Tap Count: \(tapCount)") {
            tapCount += 1
        }
    }
}

#Preview {
    ContentView()
}
