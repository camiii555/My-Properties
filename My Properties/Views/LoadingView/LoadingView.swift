//
//  LoadingView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 9/04/25.
//

import SwiftUI

struct LoadingView: View {
    var text: String
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            ProgressView(text)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.8))
                )
        }
    }
}

#Preview {
    LoadingView(text: "Cargando...")
}
