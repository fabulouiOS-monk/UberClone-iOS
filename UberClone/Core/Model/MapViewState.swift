//
//  MapViewState.swift
//  UberClone
//
//  Created by Kailash Bora on 27/01/24.
//

import Foundation

/// Using a enum instead of boolean variables for showing and hiding views
/// since that would be a lot of confusion and hassle to manage all
/// those booleans. 
enum MapViewState {
    case noInput
    case searchingForLocation
    case locationSelected
}
