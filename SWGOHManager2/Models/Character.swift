//
//  Character.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 28.10.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import SwiftUI
import Foundation

struct Character: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let body: String
    
}

