//
//  HomeView.swift
//  WaterDropWaveFormAnimation
//
//  Created by nakamura motoki on 2022/02/17.
//

import SwiftUI

struct HomeView: View {
    @State private var progress: CGFloat = 0.5
    @State private var startAnimation: CGFloat = 0
    var body: some View {
        VStack{
            Image("Pic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(10)
                .background(.white,in: Circle())
            
            Text("iJustine")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .padding(.bottom, 30)
            
            
            // MARK: Wave Form
            GeometryReader{ proxy in
                let size = proxy.size
                
                
                ZStack{
                    // MARK: Water Drop
                    Image(systemName: "drop.fill")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                    // Streching in X Axis
                        .scaleEffect(x: 1.1, y: 1)
                        .offset(y: -1)
                    
                    // Wave Form Shape
                    WaterWave(progress: 0.5, waveHeight: 0.1, offset: startAnimation)
                        .fill(Color("Blue"))
                    // Water Drops
                        .overlay(content: {
                            ZStack{
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 15)
                                    .offset(x: -20)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 15)
                                    .offset(x: 40, y: 30)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 25, height: 25)
                                    .offset(x: -30, y: 80)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 10, height: 10)
                                    .offset(x: 40, y: 100)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 10, height: 10)
                                    .offset(x: -40, y: 50)
                            }
                        })//.overlay
                    // Masking into Drop Shape
                        .mask{
                            Image(systemName: "drop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                        }//.mask
                    // Add Button
                        .overlay(alignment: .bottom){
                            Button{
                                
                            }label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 40, weight: .black))
                                    .foregroundColor(Color("Blue"))
                                    .shadow(radius: 2)
                                    .padding(25)
                                    .background(.white,in: Circle())
                            }
                            .offset(y: 40)
                        }//overlay
                }// ZStack
                // 画像を真ん中に
                .frame(width: size.width, height: size.height, alignment: .center)
                .onAppear {
                    
                    // Lopping Animation
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)){
                        // If you set value less than the rect width it will not finish completely
                        startAnimation = size.width
                    }
                }// onAppear
            }//GeometryReader
            .frame(height: 350)
            
        }//VStack
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("BG"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct WaterWave: Shape{
    
    var progress: CGFloat
    // Wave Height
    var waveHeight : CGFloat
    //Initial Animation Start
    var offset: CGFloat
    
    //Enabling Animation
    var animatableData: CGFloat{
        get{offset}
        set{offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            path.move(to: .zero)
            
            // MARK: Drawing Waves using Sine
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2){
                let x: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees: value + offset).radians)
                let y: CGFloat = progressHeight + (height * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            // Bottom Portion
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        }
    }
}
