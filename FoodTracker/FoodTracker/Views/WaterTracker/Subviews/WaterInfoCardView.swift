//
//  WaterInfoCardView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 23.02.26.
//

import SwiftUI

struct WaterInfoCardView: View {
    
    var body: some View {
        HStack {
            Text("Menschen sollten täglich etwa 2000 ml Wasser trinken, um ausreichend hydriert zu bleiben.")
                .font(.system(size: 14))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color.blue, Color.blue.opacity(0.7)],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(20)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    WaterInfoCardView()
}
