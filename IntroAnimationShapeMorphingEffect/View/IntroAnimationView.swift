//
//  IntroAnimationView.swift
//  IntroAnimationShapeMorphingEffect
//
//  Created by Abbas on 02/08/2024.
//

import SwiftUI

struct IntroAnimationView: View {
    
    @State private var  activePage: Page = .page1
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            VStack{
                Spacer(minLength: 0)
                MorPhingSymbolView(
                    symbol: activePage.pageContent,
                    config: .init(
                        font: .system(size: 150,weight: .bold),
                        frame: CGSize(width: 250, height: 200),
                                  radius: 30,
                        foregroundColor: .white
                    )
                )
//                .onTapGesture{
//                    activePage = activePage.nextPage
//                }
                TextContent(size:size)
               
                Spacer(minLength: 0)
                IndicatorView()
                ContinueButton()
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ )
            .background{
                Rectangle()
                    .fill(.black.gradient)
                    .ignoresSafeArea()
            }
            .overlay(HeaderView(),alignment: .top)
            // swipe only left and right ? 
            .gesture(DragGesture().onEnded({ value in
                if value.translation.width < 0 {
                    activePage = activePage.nextPage
                }else{
                    activePage = activePage.previousPage
                }
            }))

            
            
        }
    }
    
    @ViewBuilder
    func TextContent(size:CGSize) -> some View {
        VStack(spacing: 8){
            HStack(alignment: .top){
                ForEach(Page.allCases , id: \.rawValue){ page in
                    Text(page.rawValue)
                        .lineLimit(1)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .kerning(1.1)
                        .frame(width: size.width)
//                        .foregroundColor(.white)
//                        .opacity(page == activePage ? 1 : 0.5)
//                        .frame(width: size.width/4)
                }
            }
            .offset(x: -activePage.index * size.width )
            .animation(.smooth(duration: 0.7,extraBounce: 0.3),value: activePage)
            HStack(alignment: .top){
                ForEach(Page.allCases , id: \.rawValue){ page in
                    Text(page.rawValue)
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .frame(width: size.width)
                }
            }
            .offset(x: -activePage.index * size.width )
            .animation(.smooth(duration: 0.9,extraBounce: 0.3),value: activePage)
           
        }
        .padding(.top,15)
        .frame(width: size.width ,alignment: .leading)
    }

    @ViewBuilder
    func ContinueButton() -> some View {
        Button(action: {
            activePage = activePage.nextPage
        }, label: {
            Text(activePage == .page4 ? "Login into PS App" :"Continue")
                .contentTransition(.identity)
                .foregroundStyle(.black)
                .padding(.vertical, 15)
                .frame(maxWidth: activePage == .page4 ? 220 : 180)
                .background(.white ,in: .capsule) 
        })
    }
    
     @ViewBuilder
    func IndicatorView() -> some View {
        HStack(spacing: 0){
            ForEach(Page.allCases , id: \.rawValue){ page in
                Capsule()
                    .fill(.white.opacity(activePage == page ? 1 :0.4))
                    .frame(width: activePage == page ? 25:8, height: 8)
                    .scaleEffect(page == activePage ? 1.5 : 1)
                    .padding(.horizontal,6)
            }
        }
        .animation(.smooth (duration: 0.5 ,extraBounce: 0.1),value: activePage)
        .padding(.bottom,10)
    }

    @ViewBuilder
    func HeaderView () -> some View {
        HStack{
            Button{
                activePage = activePage .previousPage
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWidth(.standard)
                    .contentShape(.rect)
              
            }
            .opacity(activePage != .page1 ? 1 : 0)
            Spacer(minLength: 0)
            Button ("skip"){
                activePage = activePage .skipPage
            }
            .fontWeight(.semibold)
            .opacity(activePage != .page4 ? 1 : 0)
           
        }
        .animation(.smooth(duration: 0.35,extraBounce: 0),value: activePage)
        .padding(15)
        .foregroundStyle(.white)
        
    }
    
}

#Preview {
    ContentView()
}


 
