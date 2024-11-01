//
//  ContentView.swift
//  IntroAnimationShapeMorphingEffect
//
//  Created by Abbas on 02/08/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var activeID : UUID?
    var body: some View {
//        IntroAnimationView()
//            .environment(\.colorScheme,.dark)
        
        NavigationStack{
            VStack{
                CostumeCarouselView(config: .init() ,selection : $activeID , data: images) { item in
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                }
                .frame(height: 120)
                
            }
            .navigationTitle("cover carousel")
        }
    }
}

#Preview {
    ContentView()
}
