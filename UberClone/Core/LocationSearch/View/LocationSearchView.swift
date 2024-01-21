//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Kailash Bora on 21/01/24.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText = ""
    @State private var destinationLocationText = ""
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Circle()
                        .frame(width: 8, height: 6)
                        .foregroundColor(Color(.systemGray))
                    Rectangle()
                        .frame(width: 1, height: 24)
                        .foregroundColor(Color(.systemGray))
                    Rectangle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.black)
                }
                VStack {
                    TextField("Current Location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    TextField("Where To ?", text: $destinationLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top, 65)

            Divider()
                .padding(.vertical)

            ScrollView {
                VStack {
                    ForEach(1..<20, id: \.self) { _ in
                        LocationSearchResultCell()
                    }
                }
            }
        }
        .background(Color.white)
    }
}

#Preview {
    LocationSearchView()
}
