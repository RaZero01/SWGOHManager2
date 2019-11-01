//
//  Webservice.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 28.10.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import Foundation

class Webservice {
    func getData(completion: @escaping ([Character]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
            else{
            fatalError("Incorrect URL!")
        }
        URLSession.shared.dataTask(with: url) {data,_,_ in
            let characters = try! JSONDecoder().decode([Character].self, from: data!)
            DispatchQueue.main.async {
                completion(characters)
                
            }
        }.resume()
}
}
