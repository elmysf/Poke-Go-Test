//
//  RoundedView.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import Foundation
import SwiftUI

struct RoundedView: View {
     let cellWidth = UIScreen.main.bounds.width/2 - 32
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30).frame(width: cellWidth, height: 250, alignment: .center).foregroundColor(Color.blue)
                       
    }
}
