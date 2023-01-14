//
//  DishCell.swift
//  YelpRBC
//
//  Created by Chandra Sekhar Ravi on 12/01/23.
//

import UIKit

class DishCell: UICollectionViewCell {
    
    @IBOutlet weak var dishImage:UIImageView!
    
    var dishImageUrl: String? {
        didSet{
            if  dishImageUrl != nil{
                dishImage.loadImage(at: URL(string: dishImageUrl!)!)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dishImage.image = nil
        dishImage.cancelImageLoad()
    }

    
}
