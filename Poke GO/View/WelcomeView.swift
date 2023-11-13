//
//  WelcomeView.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var showWelcome: Bool
    
    var body: some View {
        ZStack{
            Image("WelcomeImage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Image("Icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
            VStack{
                Spacer()
                
                Text("Find lots of pokemon around you")
                    .font(.system(size: 14,weight: .regular, design: .rounded))
                    .foregroundColor(Color.white)
                    .padding(.bottom, 8)
                
                Button{
                    withAnimation(.default) {
                        self.showWelcome.toggle()
                    }
                } label: {
                    Text("Get Started")
                        .foregroundColor(Color.black)
                        .font(.system(size: 18,weight: .medium, design: .rounded))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.bottom, 42)
            }
            .padding(.horizontal, 32)
            
        }
    }
}
