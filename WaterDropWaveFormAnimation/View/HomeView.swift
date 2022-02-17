//
//  HomeView.swift
//  WaterDropWaveFormAnimation
//
//  Created by nakamura motoki on 2022/02/17.
//

import SwiftUI

struct HomeView: View {
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
                    
                    // Wave Form Shape
                    
                }
                // 画像を真ん中に
                .frame(width: size.width, height: size.height, alignment: .center)
            }
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
