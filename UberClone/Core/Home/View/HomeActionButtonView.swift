//
//  HomeActionButtonView.swift
//  UberClone
//
//  Created by Kailash Bora on 21/01/24.
//

import SwiftUI

struct HomeActionButtonView: View {
    @Binding var mapState: MapViewState
    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForState(mapState)
            }
        } label: {
            Image(systemName: imageForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            print("DEBUG: no input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected:
            mapState = .noInput
        }
    }

    func imageForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            "line.3.horizontal"
        case .searchingForLocation, .locationSelected :
            "arrow.backward"
        }
    }
}

#Preview {
    HomeActionButtonView(mapState: .constant(.noInput))
}
