//
//  PostCharacters.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 28.10.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class PostCharacters: ObservableObject {
    
    init() {
        fetchCharacters()
    }
    
    var characters = [Character](){
        didSet{
            didChange.send(self)
        }
    }
    
    private func fetchCharacters(){
        Webservice().getData{
            self.characters = $0
        }
    }
    
    let didChange = PassthroughSubject<PostCharacters, Never>()
    
}
