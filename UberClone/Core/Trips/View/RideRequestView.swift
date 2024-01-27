//
//  RideRequestView.swift
//  UberClone
//
//  Created by Kailash Bora on 27/01/24.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 40, height: 5)
                .padding(.top)

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
                        .foregroundColor(.black )
                }.padding(.leading)
                VStack(alignment: .leading) {
                    Text("Current Location")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(height: 32)
                        .padding(.trailing)
                        .foregroundColor(.gray)
                    Text("Where To?")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(height: 32)
                        .padding(.trailing)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("10:50 AM")
                    
                        .frame(height: 32)
                        .padding(.trailing)
                    Text("11:15 AM")
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
                    ForEach(0..<3, id: \.self) { _ in
                        VStack(alignment: .leading) {
                            Image(systemName: "car.side")
                                .resizable()
                                .scaledToFit()
                                .padding(.top)
                            Spacer()
                            VStack(spacing: 5) {
                                Text("UberX")
                                    .font(.system(size: 14, weight: .semibold))
                                Text("$12.45")
                                    .font(.system(size: 14, weight: .semibold))
                            }.padding(8)
                            
                        }
                        .frame(width: 112 , height: 140)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
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
            .background(Color(.systemGroupedBackground))
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
        }.background(.white)
    }
}

#Preview {
    RideRequestView()
}
