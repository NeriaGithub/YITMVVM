//
//  HitListViewModel.swift
//  YIT
//
//  Created by Neria Jerafi on 26/04/2021.
//

import Foundation

class HitListViewModel {
    private(set) var hitList:[Hits] = []
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
    
    var count: Int {
        return hitList.count
    }
    
    func getHitVieModelAt(index:Int) -> HitViewModel {
        return HitViewModel(imageStringURl: hitList[index].previewURL ?? "")
    }
}


class HitViewModel{
  private(set) var imageStringURl:String
    init(imageStringURl:String) {
        self.imageStringURl = imageStringURl
    }
    
    
}
