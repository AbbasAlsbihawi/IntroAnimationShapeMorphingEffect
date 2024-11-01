//
//  MorPhingSymbolView.swift
//  IntroAnimationShapeMorphingEffect
//
//  Created by Abbas on 02/08/2024.
//

import SwiftUI

struct MorPhingSymbolView: View {
    var symbol :String
    var config : Config
    // View Properties
    @State private var  trigger :Bool = false
    @State private var displayingSymbol :String = ""
    @State private var nextSymbol :String = ""
     
    
    var body: some View {
        Canvas{ctx ,size in
            ctx.addFilter(.alphaThreshold(min: 0.4,color: config.foregroundColor))
            if let  reandFill =  ctx.resolveSymbol(id: 0){
                
                ctx.draw(reandFill, at: CGPoint(x: size.width/2, y:size.height/2))
            }
        }
    symbols:{
            ImageView()
                .tag(0)
        }
    .frame(width:config.frame.width,height: config.frame.height)
    .onChange(of: symbol ){ oldValue, newValue in
        trigger.toggle()
        nextSymbol = newValue
    }
    .task {
        guard displayingSymbol == "" else { return}
        displayingSymbol = symbol
    }
//    .onTapGesture {
//        trigger.toggle()
//    }
    }
    
    @ViewBuilder 
    func ImageView() -> some View {
        KeyframeAnimator(initialValue: CGFloat.zero, trigger: trigger) { radius in
            Image(systemName: displayingSymbol)
                .font(config.font)
            
                .blur(radius: radius)
                .frame(width:config.frame.width,height: config.frame.height)
                .onChange(of: radius) { oldValue, newValue in
                    if newValue.rounded() == config.radius {
                        withAnimation(config.symbolAnimation){
                        displayingSymbol = nextSymbol
                        }
                    }
                }
            
        } keyframes: { _ in
            CubicKeyframe(config.radius, duration: config.KeyframeDuration)
            CubicKeyframe(0, duration: config.KeyframeDuration)

            
        }

        
       
        
    }
    
    struct Config{
        var font : Font
        var frame :CGSize
        var radius :CGFloat
        var foregroundColor :Color
        var KeyframeDuration  :CGFloat = 0.4
        var symbolAnimation : Animation  = .smooth(duration: 0.4,extraBounce: 0)
    }
   
}

#Preview {
    MorPhingSymbolView(symbol: "gearshape.fill", config: .init(font: .system(size: 100,weight: .bold), frame: CGSize(width: 200, height: 200),
                                                  radius: 15,foregroundColor: .black))
}
