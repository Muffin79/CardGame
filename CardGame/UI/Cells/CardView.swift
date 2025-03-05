//
//  CardView.swift
//  Test
//
//  Created by Maksim Zakhorolskiy on 02.03.2025.
//

import SwiftUI

fileprivate let cardCornerRadius: CGFloat = 12

struct CardFrontView: View {
    var color: Color?
    
    var body: some View {
        Color(color ?? .red)//.red)
            .cornerRadius(cardCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cardCornerRadius)
                    .inset(by: 2) // inset value should be same as lineWidth in .stroke
                    .stroke(.black, lineWidth: 2)
            )
    }
    
}

struct CardBackView: View {

    var body: some View {
        Color(.white)
            .cornerRadius(cardCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cardCornerRadius)
                    .inset(by: 2) // inset value should be same as lineWidth in .stroke
                    .stroke(.black, lineWidth: 2)
            )
    }
    
}

struct CardView: View {
    @State private var frontRotationAngle: Double = -90
    @State private var backRotationAngle: Double = 0
    
    let flipAnimationDuration = 0.1
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
//        guard cardItem.canFlip else { return }
        if isFliped {
            withAnimation(.linear(duration: flipAnimationDuration)) {
                backRotationAngle = 90
            }
            
            withAnimation(.linear(duration: flipAnimationDuration).delay(flipAnimationDuration)) {
                frontRotationAngle = 0
            }
        } else {
            withAnimation(.linear(duration: flipAnimationDuration)) {
                frontRotationAngle = -90
            }
            
            withAnimation(.linear(duration: flipAnimationDuration).delay(flipAnimationDuration)) {
                backRotationAngle = 0
            }
        }
    }
}

#Preview {
    CardView(cardItem: CardItem.testItems[0])
}
