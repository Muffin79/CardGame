//
//  CardView.swift
//  Test
//
//  Created by Maksim Zakhorolskiy on 02.03.2025.
//

import SwiftUI

struct CardFrontView: View {
    var color: Color?
    
    var body: some View {
        Color(color ?? .red)//.red)
            .cornerRadius(CardConfiguration.cardCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: CardConfiguration.cardCornerRadius)
                    .inset(by: 2) // inset value should be same as lineWidth in .stroke
                    .stroke(.black, lineWidth: 2)
            )
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
            CardFrontView(color: cardItem.color)
                .rotation3DEffect(.degrees(frontRotationAngle),
                                  axis: (x: 0, y: 1, z: 0))
           
            CardBackView()
                .rotation3DEffect(.degrees(backRotationAngle),
                                  axis: (x: 0, y: 1, z: 0))
        }.onReceive(cardItem.$isFliped
            .dropFirst()
            .removeDuplicates()) { value in
            print("Value received \(value)")
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
    CardView(cardItem: CardItem.testItems[0])
}
