//
//  CardView.swift
//  Test
//
//  Created by Maksim Zakhorolskiy on 02.03.2025.
//

import SwiftUI

struct CardFrontView: View {
    var color: Color?
    var iconName: String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
            Color(color ?? .white)
                .cornerRadius(CardConfiguration.cardCornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: CardConfiguration.cardCornerRadius)
                        .inset(by: 2) // inset value should be same as lineWidth in .stroke
                        .stroke(.black, lineWidth: 2)
                )
            if let iconName = iconName {
                Image(systemName: iconName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
            }
            
        }
    }
    
}

struct CardBackView: View {

    var body: some View {
        Color(.white)
            .cornerRadius(CardConfiguration.cardCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: CardConfiguration.cardCornerRadius)
                    .inset(by: 2) // inset value should be same as lineWidth in .stroke
                    .stroke(.black, lineWidth: 2)
            )
    }
    
}

struct CardView: View {
    @State private var frontRotationAngle: Double = -90
    @State private var backRotationAngle: Double = 0
    
    var cardItem: CardItem
    
    var body: some View {
        ZStack {
            CardFrontView(color: cardItem.color, iconName: cardItem.iconName)
                .rotation3DEffect(.degrees(frontRotationAngle),
                                  axis: (x: 0, y: 1, z: 0))
           
            CardBackView()
                .rotation3DEffect(.degrees(backRotationAngle),
                                  axis: (x: 0, y: 1, z: 0))
        }.onReceive(cardItem.$isFliped
            .dropFirst()
            .removeDuplicates()) { value in
                flipAnimation(value)
        }
    }
    
    func flipAnimation(_ isFliped: Bool) {
        if isFliped {
            withAnimation(.linear(duration: CardConfiguration.flipAnimationDuration)) {
                backRotationAngle = 90
            }
            
            withAnimation(.linear(duration: CardConfiguration.flipAnimationDuration).delay(CardConfiguration.flipAnimationDuration)) {
                frontRotationAngle = 0
            }
        } else {
            withAnimation(.linear(duration: CardConfiguration.flipAnimationDuration)) {
                frontRotationAngle = -90
            }
            
            withAnimation(.linear(duration: CardConfiguration.flipAnimationDuration).delay(CardConfiguration.flipAnimationDuration)) {
                backRotationAngle = 0
            }
        }
    }
}

#Preview {
    CardView(cardItem: CardItem(type: .icon("suit.diamond.fill")))
}
