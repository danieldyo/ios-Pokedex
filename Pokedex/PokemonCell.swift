//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Home on 12/30/15.
//  Copyright © 2015 DanielOng. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var Lbl: UILabel!
    
    var pokemon: Pokemon!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        Lbl.text = self.pokemon.name.capitalizedString
        Img.image = UIImage(named: "\(self.pokemon.Id)")
    }

}
