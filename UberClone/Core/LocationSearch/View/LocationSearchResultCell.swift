//
//  LocationSearchResultCell.swift
//  UberClone
//
//  Created by Kailash Bora on 21/01/24.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var placeNameText: String
    var placeAddressText: String
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 4) {
                Text(placeNameText)
                    .font(.body)
                Text(placeAddressText)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.horizontal)
    }
}

#Preview {
    LocationSearchResultCell()
}
