//
//  HitListViewModel.swift
//  YIT
//
//  Created by Neria Jerafi on 26/04/2021.
//

import Foundation

class HitListViewModel {
    
    // MARK:- Properties
    private(set) var hitList:[Hits] = []
    
    var count: Int {
        return hitList.count
    }
    // MARK:- Hit List View Model methods
    func fetchData(completion:@escaping()->()) {
        WebService.getRequest { [weak self](result:Result<DataModel,WebServiceError>) in
            guard let strongSelf = self else {return}
            switch result {
            case .success(let dataModel):
                strongSelf.hitList = dataModel.hits
                completion()
            case .failure(_):
                print("error")
            }
        }
    }
    func getHitVieModelAt(index:Int) -> HitViewModel {
        return HitViewModel(imageStringURl: hitList[index].previewURL ?? "")
    }
}



