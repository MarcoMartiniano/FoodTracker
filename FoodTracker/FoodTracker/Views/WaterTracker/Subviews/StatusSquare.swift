//
//  StatusSquare.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 23.02.26.
//

import SwiftUI

struct StatusSquare: View {
    var status: CardStatus
    var cornerRadius: CGFloat = 10
    var size: CGSize = CGSize(width: 25, height: 20)
    var strokeColor: Color = .gray
    var strokeWidth: CGFloat = 0.5

    var body: some View {
        ZStack {
            backgroundView
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(strokeColor, lineWidth: strokeWidth)
        )
        .frame(width: size.width, height: size.height)
    }

    @ViewBuilder
    private var backgroundView: some View {
        switch status {
        case .solidBlack:
            Color(AppColors.lightBlue)
        case .striped:
            DiagonalStripes()
        case .partial(let percent):
            ZStack(alignment: .bottom) {
                DiagonalStripes()
                Color(AppColors.lightBlue)
                    .frame(height: CGFloat(percent) * size.height)
            }
        }
    }
}

struct DiagonalStripes: View {
    var stripeColor: Color = .white
    var backgroundColor: Color = .black
    var stripeWidth: CGFloat = 4
    var spacing: CGFloat = 2

    var body: some View {
        Canvas { context, size in
            context.fill(
                Path(CGRect(origin: .zero, size: size)),
                with: .color(backgroundColor)
            )

            context.rotate(by: .degrees(45))

            let totalWidth = size.width + size.height
            var x: CGFloat = -totalWidth

            while x < totalWidth {
                let rect = CGRect(
                    x: x,
                    y: -totalWidth,
                    width: stripeWidth,
                    height: totalWidth * 2
                )
                context.fill(
                    Path(rect),
                    with: .color(stripeColor)
                )
                x += stripeWidth + spacing
            }
        }
    }
}

#Preview {
    StatusSquare(status: .solidBlack)
          .frame(width: 150, height: 150)
      
      StatusSquare(status: .striped)
          .frame(width: 150, height: 150)
    StatusSquare(status: .partial(0.5))
        .frame(width: 150, height: 150)
}
