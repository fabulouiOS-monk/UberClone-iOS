//
//  RideType.swift
//  UberClone
//
//  Created by Kailash Bora on 27/01/24.
//

import Foundation

enum RideType: Int, Identifiable, CaseIterable {
    case uberX
    case black
    case uberXL

    var id: Int { return rawValue}

    var description: String {
        switch self {
        case .uberX: return "UberX"
        case .black: return "UberBlack"
        case .uberXL: return "UberXL"
        }
    }

    var imageName: String {
        switch self {
        case .uberX: return "uber-x"
        case .black: return "uber-black"
        case .uberXL: return "uber-xl"
        }
    }

    var baseFare: Double {
        switch self {
        case .uberX: return 5
        case .black: return 20
        case .uberXL: return 10
        }
    }

    func computePrice(for distanceInMeter: Double) -> Double {
        let distanceInMiles = distanceInMeter / 1600
        
        switch self {
        case .uberX: return distanceInMiles * 1.5 + baseFare
        case .black: return distanceInMiles * 2.0 + baseFare
        case .uberXL: return distanceInMiles * 1.75 + baseFare
        }
    }
}
