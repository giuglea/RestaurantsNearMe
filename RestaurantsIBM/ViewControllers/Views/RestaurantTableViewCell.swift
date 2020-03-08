//
//  RestaurantTableViewCell.swift
//  RestaurantsIBM
//
//  Created by DragosRotaru on 28/02/2020.
//  Copyright © 2020 DragosRotaru. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet var starImage: [UIImageView]!
    
    let starFill = "star.fill"
    let starEmpty = "star"
    let starHalf = "star.lefthalf.fill"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setRatingStars(rating: Double){
        
        starImage[0].image = UIImage(systemName: starEmpty)
        starImage[1].image = UIImage(systemName: starEmpty)
        starImage[2].image = UIImage(systemName: starEmpty)
        starImage[3].image = UIImage(systemName: starEmpty)
        starImage[4].image = UIImage(systemName: starEmpty)
        
        for i in 0..<Int(rating){
            starImage[i].image = UIImage(systemName: starFill)
        }
        
        
         
       }
    
    
   func  setRatingStarAlternative(rating: Double){
        switch rating {
                 case 0..<0.4:
                     starImage[0].image = UIImage(systemName: starEmpty)
                     starImage[1].image = UIImage(systemName: starEmpty)
                     starImage[2].image = UIImage(systemName: starEmpty)
                     starImage[3].image = UIImage(systemName: starEmpty)
                     starImage[4].image = UIImage(systemName: starEmpty)
                 case 0.4..<1:
                     starImage[0].image = UIImage(systemName: starHalf)
                     starImage[1].image = UIImage(systemName: starEmpty)
                     starImage[2].image = UIImage(systemName: starEmpty)
                     starImage[3].image = UIImage(systemName: starEmpty)
                     starImage[4].image = UIImage(systemName: starEmpty)
                 case 1..<1.4:
                     starImage[0].image = UIImage(systemName: starFill)
                     starImage[1].image = UIImage(systemName: starEmpty)
                     starImage[2].image = UIImage(systemName: starEmpty)
                     starImage[3].image = UIImage(systemName: starEmpty)
                     starImage[4].image = UIImage(systemName: starEmpty)
                 case 1.4..<2:
                     starImage[0].image = UIImage(systemName: starFill)
                     starImage[1].image = UIImage(systemName: starHalf)
                     starImage[2].image = UIImage(systemName: starEmpty)
                     starImage[3].image = UIImage(systemName: starEmpty)
                     starImage[4].image = UIImage(systemName: starEmpty)
                 case 2..<2.4:
                     starImage[0].image = UIImage(systemName: starFill)
                     starImage[1].image = UIImage(systemName: starFill)
                     starImage[2].image = UIImage(systemName: starEmpty)
                     starImage[3].image = UIImage(systemName: starEmpty)
                     starImage[4].image = UIImage(systemName: starEmpty)
                 case 2.4..<3:
                     starImage[0].image = UIImage(systemName: starFill)
                     starImage[1].image = UIImage(systemName: starFill)
                     starImage[2].image = UIImage(systemName: starHalf)
                     starImage[3].image = UIImage(systemName: starEmpty)
                     starImage[4].image = UIImage(systemName: starEmpty)
                 case 3..<3.4:
                     starImage[0].image = UIImage(systemName: starFill)
                     starImage[1].image = UIImage(systemName: starFill)
                     starImage[2].image = UIImage(systemName: starFill)
                     starImage[3].image = UIImage(systemName: starEmpty)
                     starImage[4].image = UIImage(systemName: starEmpty)
                 case 3.4..<4:
                     starImage[0].image = UIImage(systemName: starFill)
                     starImage[1].image = UIImage(systemName: starFill)
                     starImage[2].image = UIImage(systemName: starFill)
                     starImage[3].image = UIImage(systemName: starHalf)
                     starImage[4].image = UIImage(systemName: starEmpty)
                 case 4..<4.4:
                     starImage[0].image = UIImage(systemName: starFill)
                     starImage[1].image = UIImage(systemName: starFill)
                     starImage[2].image = UIImage(systemName: starFill)
                     starImage[3].image = UIImage(systemName: starFill)
                     starImage[4].image = UIImage(systemName: starEmpty)
                 case 4.4..<4.9:
                     starImage[0].image = UIImage(systemName: starFill)
                     starImage[1].image = UIImage(systemName: starFill)
                     starImage[2].image = UIImage(systemName: starFill)
                     starImage[3].image = UIImage(systemName: starFill)
                     starImage[4].image = UIImage(systemName: starHalf)
                 case 4.9...5:
                     starImage[0].image = UIImage(systemName: starFill)
                     starImage[1].image = UIImage(systemName: starFill)
                     starImage[2].image = UIImage(systemName: starFill)
                     starImage[3].image = UIImage(systemName: starFill)
                     starImage[4].image = UIImage(systemName: starFill)

                 default:
                     starImage[0].image = UIImage(systemName: starEmpty)
                     starImage[1].image = UIImage(systemName: starEmpty)
                     starImage[2].image = UIImage(systemName: starEmpty)
                     starImage[3].image = UIImage(systemName: starEmpty)
                     starImage[4].image = UIImage(systemName: starEmpty)
                 }
    }
       
       
    
}
