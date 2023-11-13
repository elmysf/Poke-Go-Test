//
//  ErrorView.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 13/11/23.
//

import SwiftUI

struct ErrorView: View {
    var error: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("Error")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .padding()
            
            Text(error)
                .padding(.horizontal, 20)
                
            Spacer()
        }
    }
}

