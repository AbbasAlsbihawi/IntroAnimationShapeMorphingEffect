//
//  CostumeCarouselView.swift
//  IntroAnimationShapeMorphingEffect
//
//  Created by Abbas on 03/08/2024.
//

import SwiftUI

struct CostumeCarouselView<Content :View ,Data :RandomAccessCollection> : View where Data.Element :Identifiable {
    
    var config : Config
    @Binding var selection :  Data.Element.ID?
    var data :Data
    @ViewBuilder var content :(Data.Element)-> Content
    var body: some View {
       
        GeometryReader{
            let size = $0.size
            ScrollView(.horizontal){
                HStack(spacing: config.spacing){
                    ForEach(data){ item in
                        // item View
                        ItemView(item)
                        
                    }
                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal,(size.width - config.cardWidth)/2)
            .scrollPosition(id: $selection)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .scrollIndicators(.hidden)
            
        }
    }
    
    //  item View
    
    @ViewBuilder
    func ItemView(_ item : Data.Element ) -> some View {
        
        GeometryReader { proxy in
        let size = proxy.size

        let minX = proxy.frame(in: .scrollView(axis:.horizontal)).minX
        let progress =  minX / (config.cardWidth + config.spacing)
        let minCardWidth =  config.minCardWidth

        let diffWidth = config.cardWidth - minCardWidth

        let reducingWidth = diffWidth * progress

        let cappedWidth = max(minCardWidth , reducingWidth)

        let resizedFrameWidth = size.width - cappedWidth
 
            content(item)
            .frame(width: size.width, height: size.height)
            .frame(width: resizedFrameWidth)
            .clipShape(.rect(cornerRadius: config.cardCornerRadius))
            
        }
        .frame(width: config.cardWidth)

        
    }
    
    
    struct Config {
        
        var hasOpacity : Bool = false
        var opacityValue: CGFloat = 0.5
        var hasScale :Bool = false
        var scaleValue: CGFloat = 0.2
        
        var cardWidth: CGFloat = 150
        var cardHeight: CGFloat = 100
        var spacing: CGFloat = 10
        
        var cardCornerRadius: CGFloat = 15
        var minCardWidth: CGFloat = 40
        
        
        
    }
}

#Preview {
    ContentView()
}
