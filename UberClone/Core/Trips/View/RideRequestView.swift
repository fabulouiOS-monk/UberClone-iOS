//
//  RideRequestView.swift
//  UberClone
//
//  Created by Kailash Bora on 27/01/24.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType: RideType = .uberX
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 40, height: 5)
                .padding(.top, 5)

            /// Location and time view
            HStack {
                VStack {
                    Circle()
                        .frame(width: 8, height: 6)
                        .foregroundColor(.gray)
                    Rectangle()
                        .frame(width: 1, height: 24)
                        .foregroundColor(.gray)
                    Rectangle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(Color.theme.primaryTextColor)
                }.padding(.leading)
                VStack(alignment: .leading) {
                    Text("Current Location")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(height: 32)
                        .padding(.trailing)
                        .foregroundColor(.gray)
                    if let uberLocation = locationViewModel.selectedUberLocation {
                        Text(uberLocation.title)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(height: 32)
                            .padding(.trailing)
                    }
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(locationViewModel.pickUpTime ?? "")
                        .frame(height: 32)
                        .padding(.trailing)
                    Text(locationViewModel.dropOffTime ?? "")
                        .frame(height: 32)
                        .padding(.trailing)
                }
                .foregroundColor(.gray)
                .font(.system(size: 16))
            }.padding()

            Divider()

            /// Suggested rides and pricing
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(RideType.allCases) { rideType in
                        VStack(alignment: .leading) {
                            Image(rideType.imageName)
                                .resizable()
                                .scaledToFit()
                                .padding(.top)
                            Spacer()
                            VStack(alignment: .leading, spacing: 4) {
                                Text(rideType.description)
                                    .font(.system(size: 14, weight: .semibold))
                                Text(locationViewModel.computePrice(forType: rideType).toCurrency())
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding()
                        }
                        .frame(width: 112 , height: 140)
                        .background(rideType == selectedRideType ? Color(.systemBlue) :
                                        Color.theme.secondaryBackgroundColor)
                        .foregroundColor(rideType == selectedRideType ? .white :
                                            Color.theme.primaryTextColor)
                        .scaleEffect(rideType == selectedRideType ? 1.1 : 1.0)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedRideType = rideType
                            }
                        }
                    }
                }.padding(.horizontal)
            }

            Divider()
                .padding(.vertical, 8)

            /// Payment option
            HStack(spacing: 12) {
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                Text("***** 1234")
                    .fontWeight(.bold)
                    .padding(6)
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color.theme.secondaryBackgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)

            /// Confirm ride button
            Button {
                
            } label: {
                Text("Confirm Ride")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.bottom, 24)
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)
        
    }
}

#Preview {
    RideRequestView()
}
