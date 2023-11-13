//
//  FloatingFilterButton.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import Foundation
import SwiftUI

struct ActionButton: View {
    var imageName: String
    var height: CGFloat = 24
    var width: CGFloat = 24
    var backgroundColor: Color = .purple
    @Binding var show: Bool

    var action: () -> Void

    var body: some View {
        Button(action: { action() }, label: {
            Image(imageName)
                .resizable()
                .frame(width: width, height: height)
                .padding(16)
        })
        .background(Color.black)
        .foregroundColor(.white)
        .clipShape(Circle())
    }
}
