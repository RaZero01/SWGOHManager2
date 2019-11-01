//
//  DetailShipInfo.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 31.10.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import SwiftUI

struct DetailShipInfo: View {
    
    let ship: Ship
    
    var body: some View {
        VStack(spacing: 20) {
            Text(ship.name)
                .font(.largeTitle)
            imageView(url: "https://swgoh.gg" + ship.image)
            Text(ship.alignment)
                .font(.title)
            Text(ship.role)
                .font(.title)
            Text(ship.description)
                .frame(minHeight: 70)
                .padding()
                .font(.title)
        }
    }
}

