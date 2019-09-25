//
//  UserResponse.swift
//  ReachabilityExample
//
//  Created by Станислав Шияновский on 9/25/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Foundation

public struct UserResponse: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
