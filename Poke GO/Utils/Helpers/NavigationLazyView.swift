//
//  NavigationLazyView.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import Foundation
import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
