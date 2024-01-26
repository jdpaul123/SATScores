//
//  View+Banner.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import SwiftUI

extension View {
    /// This method allows the banner to be shown from any view in the app
    func banner(data: Binding<BannerModifier.BannerData>, show: Binding<Bool>) -> some View {
        self.modifier(BannerModifier(data: data, show: show))
    }
}
