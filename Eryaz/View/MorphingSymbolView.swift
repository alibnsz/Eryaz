//
//  MorphingSymbolView.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 30.07.2024.
//

import SwiftUI

struct MorphingSymbolView: View {
    var symbol: String
    var config: Config

    @State private var trigger: Bool = false
    @State private var displayinSymbol: String = ""
    @State private var nextSymbol: String = ""
    
    var body: some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.4, color: config.foregroundColor))
            
            if let renderImage = context.resolveSymbol(id: 0) {
                context.draw(renderImage, at: CGPoint(x: size.width / 2, y: size.height / 2))
            }
        } symbols: {
            ImageView()
                .tag(0)
        }
        .frame(width: config.frame.width, height: config.frame.height)
        .onChange(of: symbol) { oldValue, newValue in
            trigger.toggle()
            nextSymbol = newValue
        }
        .task {
            guard displayinSymbol == "" else { return }
            displayinSymbol = symbol
        }
    }
    
    @ViewBuilder
    func ImageView() -> some View {
        KeyframeAnimator(initialValue: CGFloat.zero, trigger: trigger) { radius in
            Image(systemName: displayinSymbol)
                .font(config.font)
                .blur(radius: radius)
                .foregroundStyle(config.foregroundColor)
                .frame(width: config.frame.width, height: config.frame.height)
                .onChange(of: radius) { oldValue, newValue in
                    if newValue.rounded() == config.radius {
                        withAnimation(config.symbolAnimation) {
                            displayinSymbol = nextSymbol
                        }
                    }
                }

        } keyframes: { _ in
            CubicKeyframe(config.radius, duration: config.keyFrameDuration)
            CubicKeyframe(0, duration: config.keyFrameDuration)

        }

            }
    
    struct Config {
        var font: Font
        var frame: CGSize
        var radius: CGFloat
        var foregroundColor: Color
        var keyFrameDuration: CGFloat = 0.4
        var symbolAnimation: Animation = .smooth(duration: 0.5, extraBounce: 0)
    }
}
