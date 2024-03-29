//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Kailash Bora on 21/01/24.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText = ""
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    @Binding var mapState: MapViewState
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
                        .foregroundColor(Color.theme.primaryTextColor)
                }
                VStack {
                    TextField("Current Location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color.theme.secondaryBackgroundColor)
                        .padding(.trailing)
                    TextField("Where To ?", text: $locationSearchViewModel.queryFragment) 
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
                    ForEach(locationSearchViewModel.result, id: \.self) { result in
                        LocationSearchResultCell(placeNameText: result.title,
                                                 placeAddressText: result.subtitle)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                locationSearchViewModel.selectLocation(result)
                                mapState = .locationSelected
                            }
                        } 
                    }
                }
            }
        }
        .background(Color.theme.backgroundColor)
    }
}

#Preview {
    LocationSearchView(mapState: .constant(.searchingForLocation))
}
