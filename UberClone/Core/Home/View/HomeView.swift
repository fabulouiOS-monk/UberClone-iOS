//
//  HomeView.swift
//  UberClone
//
//  Created by Kailash Bora on 21/01/24.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .top) {
                    UberMapViewRepresentable(mapState: $mapState)
                        .ignoresSafeArea()
                    if mapState == .searchingForLocation {
                        LocationSearchView(mapState: $mapState)
                    } else if mapState == .noInput {
                        LocationSearchActivationView()
                            .padding(.top, 75)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    mapState = .searchingForLocation
                                }
                            }
                    }
                    HomeActionButtonView(mapState: $mapState)
                        .padding(.leading)
                        .padding(.top, 4)
                }
                
                if mapState == .locationSelected || mapState == .polylineAdded {
                    RideRequestView()
                        .transition(.move(edge: .bottom))
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .onReceive(LocationManager.shared.$userLocation) { location in
                if let location {
                    locationViewModel.userLocation = location
                }
            }

            if mapState == .profileView {
                VStack {
                    Text("Profile View")
                }
                .frame(width: UIScreen.main.bounds.width - 20)
                .background(Color.theme.backgroundColor)
                .ignoresSafeArea()
                .transition(.move(edge: .leading))
            }
        }
    }
}

#Preview {
    HomeView()
}
