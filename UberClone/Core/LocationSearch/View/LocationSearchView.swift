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
    @Binding var showLocationSearchView: Bool
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
                            locationSearchViewModel.selectLocation(result)
                            showLocationSearchView.toggle()
                        }
                    }
                }
            }
        }
        .background(Color.white)
    }
}

#Preview {
    LocationSearchView(showLocationSearchView: .constant(true))
}
