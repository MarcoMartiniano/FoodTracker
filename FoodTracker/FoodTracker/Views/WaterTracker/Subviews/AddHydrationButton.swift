//
//  AddHydrationButton.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 23.02.26.
//

import SwiftUI

struct AddHydrationButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                
                Text("Neue Wasseraufnahme hinzufügen")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                    
                    Image(systemName: AppIcons.plus)
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .bold))
                }
            }
            .padding()
            .background(Color.black)
            .opacity(0.9)
            .cornerRadius(24)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    AddHydrationButton(action: {})
}
