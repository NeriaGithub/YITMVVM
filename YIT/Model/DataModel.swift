//
//  DataModel.swift
//  YIT
//
//  Created by Neria Jerafi on 26/04/2021.
//

import Foundation

struct DataModel:Decodable {
    let hits:[Hits]
}
struct Hits:Decodable {
    let previewURL:String?
    
}
