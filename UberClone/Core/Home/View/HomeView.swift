//
//  HomeView.swift
//  UberClone
//
//  Created by Kailash Bora on 21/01/24.
//

import SwiftUI

struct HomeView: View {
    @State private var shouldShowLocationSearchView = false
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            if shouldShowLocationSearchView {
                LocationSearchView()
            } else {
                LocationSearchActivationView()
                    .padding(.top, 75)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            shouldShowLocationSearchView.toggle()
                        }
                    }
            }
            HomeActionButtonView(isShowingSearchView: $shouldShowLocationSearchView)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

#Preview {
    HomeView()
}
