//
//  PokeCell.swift
//  pokedex
//
//  Created by 呂易軒 on 2017/9/29.
//  Copyright © 2017年 呂易軒. All rights reserved.
//

import UIKit

// Don't forget to set 1.class 2.reuse identifier

// Custom code for collection cell
class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    //for update cell
    func configureCell(_ pokemon: Pokemon){
        
        nameLbl.text = pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(pokemon.id)")
        
    }
    
    
    // implement rounded corner(to modify how the layer looks)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 8.0
    }
}
