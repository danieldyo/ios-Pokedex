//
//  PokeDetailVC.swift
//  Pokedex
//
//  Created by Home on 1/2/16.
//  Copyright © 2016 DanielOng. All rights reserved.
//

import UIKit

class PokeDetailVC: UIViewController {
    
    var poke: Pokemon!
    
    @IBOutlet weak var PokeName: UILabel!
    @IBOutlet weak var MainImg: UIImageView!
    @IBOutlet weak var Desc: UILabel!
    @IBOutlet weak var Type: UILabel!
    @IBOutlet weak var DefenseLbl: UILabel!

    @IBOutlet weak var IDLbl: UILabel!
    @IBOutlet weak var HeightLbl: UILabel!
    
    @IBOutlet weak var WeightLbl: UILabel!
    @IBOutlet weak var AttackLbl: UILabel!
    
    @IBOutlet weak var NextEvoLbl: UILabel!
    
    @IBOutlet weak var currentEvoImg: UIImageView!
    
    
    @IBOutlet weak var NextEvoImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokeName.text = poke.name.capitalizedString
        MainImg.image = UIImage(named: "\(poke.Id)")
        poke.downloadDetails{ () -> () in
            // called after download is done
            self.updateVC()
        }

    }
    
    func updateVC() {
        Desc.text = poke.desc
        Type.text = poke.type
        DefenseLbl.text = poke.defense
        WeightLbl.text = poke.weight
        AttackLbl.text = poke.baseatk
        IDLbl.text = "\(poke.Id)"
        HeightLbl.text = poke.height
        currentEvoImg.image = UIImage(named: "\(poke.Id)")
        if poke.nextEvoTxt == "" {
            NextEvoLbl.text = "N/A"
            NextEvoImg.hidden = true
        }
        else {
            NextEvoImg.hidden = false
            NextEvoImg.image = UIImage(named: poke.nextEvoId)
            var str = poke.nextEvoTxt
            if poke.nextEvoLvl != "" {
                str += " - LVL \(poke.nextEvoLvl)"
            }
             NextEvoLbl.text = str
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func GoBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

