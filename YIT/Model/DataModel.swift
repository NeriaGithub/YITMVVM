//
//  DataModel.swift
//  YIT
//
//  Created by Neria Jerafi on 26/04/2021.
//

import Foundation

struct DataModel:Decodable {
    //var total:Int?
    //var totalHits:Int?
    let hits:[Hits]
}
struct Hits:Decodable {
    let previewURL:String?
    
}
