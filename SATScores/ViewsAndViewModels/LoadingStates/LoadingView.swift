//
//  LoadingScreen.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import SwiftUI

struct LoadingView: View {
    @State private var isRotating = 0.0

    var body: some View {
        VStack(spacing: 20) {
            Image(.satLogo)
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(10)
                .rotationEffect(.degrees(isRotating))
                .onAppear {
                    withAnimation(.linear(duration: 3.5).repeatForever(autoreverses: false)) {
                        isRotating = 360.0
                    }
                }
                .padding()
            Text("Loading...")
        }
    }
}

#Preview {
    LoadingView()
}
