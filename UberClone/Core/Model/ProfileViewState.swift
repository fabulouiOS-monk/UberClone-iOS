//
//  ProfileViewState.swift
//  UberClone
//
//  Created by Kailash Bora on 29/01/24.
//

import Foundation

enum ProfileViewState: Int, Identifiable, CaseIterable {
    case personalDetails
    case rides
    case settings

    var id: Int { return rawValue }

    var description: String {
        switch self {
        case .personalDetails: return "Personal Details"
        case .rides: return "Rides"
        case .settings: return "Settings"
        }
    }
}
