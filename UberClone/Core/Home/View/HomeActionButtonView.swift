//
//  HomeActionButtonView.swift
//  UberClone
//
//  Created by Kailash Bora on 21/01/24.
//

import SwiftUI

struct HomeActionButtonView: View {
    @Binding var isShowingSearchView: Bool
    var body: some View {
        Button {
            withAnimation(.spring()) {
                isShowingSearchView.toggle()
            }
        } label: {
            Image(systemName: isShowingSearchView ? 
                  "arrow.backward" : "line.3.horizontal")
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HomeActionButtonView(isShowingSearchView: .constant(true))
}
