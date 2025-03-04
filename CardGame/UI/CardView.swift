//
//  CardView.swift
//  Test
//
//  Created by Maksim Zakhorolskiy on 02.03.2025.
//

import SwiftUI

fileprivate let cardCornerRadius: CGFloat = 12

struct CardFrontView: View {

    var body: some View {
        Color(.red)
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
    @State private var rotated = false
    @State private var frontRotationAngle: Double = -90
    @State private var backRotationAngle: Double = 0
    
    let flipAnimationDuration = 0.2
    
    
    var body: some View {
        ZStack {
            CardFrontView()
                .rotation3DEffect(.degrees(frontRotationAngle),
                                  axis: (x: 0, y: 1, z: 0))
           
            CardBackView() .rotation3DEffect(.degrees(backRotationAngle),
                                  axis: (x: 0, y: 1, z: 0))
        }
        .onTapGesture {
            flipAnimation()
        }
    }
    
    func flipAnimation() {
        rotated.toggle()
        
        if rotated {
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
    CardView()
}
