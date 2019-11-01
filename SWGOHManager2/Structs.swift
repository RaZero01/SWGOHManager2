//
//  Structs.swift
//  SWGOHManager2
//
//  Created by Konstantin Razinkov on 30.10.2019.
//  Copyright © 2019 RaZero01. All rights reserved.
//

import Foundation


struct imageView: View{
    
    @ObservedObject var imageLoader:ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(image: url)
    }
    
    var body: some View{
        Image(uiImage: UIImage(data: imageLoader.data) ?? UIImage()).resizable().frame(width: 200, height: 200)
    }
    
}
