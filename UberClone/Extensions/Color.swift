//
//  Color.swift
//  UberClone
//
//  Created by Kailash Bora on 27/01/24.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
}
