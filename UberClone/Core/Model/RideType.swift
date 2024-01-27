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
}
