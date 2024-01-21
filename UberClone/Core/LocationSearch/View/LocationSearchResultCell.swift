//
//  LocationSearchResultCell.swift
//  UberClone
//
//  Created by Kailash Bora on 21/01/24.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 4) {
                Text("Coffe Shop")
                    .font(.body)
                Text("location details")
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
