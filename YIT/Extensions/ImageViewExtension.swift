//
//  ImageViewExtension.swift
//  YIT
//
//  Created by Neria Jerafi on 26/04/2021.
//

import Foundation
import UIKit

extension UIImageView {
    func load(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return  }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

