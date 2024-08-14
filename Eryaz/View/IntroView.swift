//
//  IntroView.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 30.07.2024.
//

import SwiftUI

struct IntroView: View {
    @State private var activePage: Page = .page1
    @State private var isHomeViewActive: Bool = false
    @Environment(\.primaryColor) private var primaryColor

    var body: some View {
        GeometryReader{
            let size = $0.size
            
            VStack{
                Spacer()
                Image("logo")
                    .opacity(0.7)

                Spacer(minLength: 0)
                MorphingSymbolView(symbol: activePage.rawValue, config: .init(font: .system(size: 130, weight: .bold), frame: .init(width: 250, height: 200), radius: 15, foregroundColor: primaryColor))
                
                TextContents(size: size)
                
                Spacer(minLength: 0)
                
                IndicatorView()
                
                ContinueButton()
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .top) {
                HeaderView()
            }
        }
        .background{
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func TextContents(size: CGSize) -> some View {
        VStack (spacing: 8) {
            HStack (spacing: 0) {
                ForEach(Page.allCases, id: \.rawValue){ page in
                    Text(page.title)
                        .lineLimit(1)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .kerning(1.1)
                        .frame(width: size.width)
                }
            }
            .offset(x: -activePage.index * size.width)
            .animation(.smooth(duration: 0.7, extraBounce: 0.2), value: activePage )
            HStack (spacing: 0) {
                ForEach(Page.allCases, id: \.rawValue){ page in
                    Text(page.subTitle)
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .frame(width: size.width)
                }
            }
            .offset(x: -activePage.index * size.width)
            .animation(.smooth(duration: 0.4, extraBounce: 0.2), value: activePage )
        }
        .padding(.top, 15)
        .frame(width: size.width, alignment: .leading)
        
        
    }
    
    @ViewBuilder
    func IndicatorView() -> some View {
        HStack (spacing: 3) {
            ForEach(Page.allCases, id: \.rawValue){ page in
                Capsule()
                    .fill(.opacity(activePage == page ? 1 : 0.4))
                    .frame(width: activePage == page ? 25 : 8, height: 8)
                
            }
        }
        .animation(.smooth(duration: 0.4, extraBounce: 0.2), value: activePage )
        .padding(.bottom, 12)
    }
    
    @ViewBuilder
    func ContinueButton() -> some View {
        Button(action: {
            if activePage == .page4 {
                isHomeViewActive = true
            } else {
                activePage = activePage.nextPage
            }
        }, label: {
            Text(activePage == .page4 ? " Giriş Yap" : "Devam Et")
                .contentTransition(.identity)
                .foregroundColor(.white)
                .padding(.vertical, 15)
                .frame(maxWidth: activePage == .page1 ? 220 : 180)
                .background(primaryColor, in: .capsule)
                
        })
        .padding(.bottom, 15)
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage )
        .fullScreenCover(isPresented: $isHomeViewActive) {
            SignInView()
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack{
            Button(action: {
                activePage = activePage.previousPage
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.bold)
                    .contentShape(.rect)
            })
            .opacity(activePage != .page1 ? 1 : 0)
            
            Spacer(minLength: 0)
            
            Button("Geç") {
                activePage = .page4
            }
            .fontWeight(.bold)
            .opacity(activePage != .page4 ? 1 : 0)
        }
        .foregroundColor(.gray)
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage )
        .padding(15)
    }
} 

#Preview {
    IntroView()
}
