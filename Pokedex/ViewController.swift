//
//  ViewController.swift
//  Pokedex
//
//  Created by Home on 12/30/15.
//  Copyright © 2015 DanielOng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchbar.delegate = self
        searchbar.returnKeyType = UIReturnKeyType.Done
        parseCSV()
    }

    func parseCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
           // print(rows)
            
            for row in rows {
                let PokemonID = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, Id: PokemonID)
                pokemon.append(poke)
            }
        } catch let err as NSError {
           print(err.debugDescription)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as? PokemonCell {
            let poke: Pokemon!
            if searching {
                poke = filteredPokemon[indexPath.row]
            }
            else {
                poke = pokemon[indexPath.row]
            }
            cell.configureCell(poke)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let poke: Pokemon!
        
        if searching{
            poke = filteredPokemon[indexPath.row]
        }
        else {
            poke = pokemon[indexPath.row]
        }
        //print(poke.name)
        performSegueWithIdentifier("PokeDetailVC", sender: poke)

    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return filteredPokemon.count
        }
        else {
        return pokemon.count
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            searching = false
            view.endEditing(true)
            //closes keyboard if above conditions are true
            collection.reloadData()
        } else {
            searching = true
            let lower = searchBar.text!.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collection.reloadData()
            
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokeDetailVC" {
            if let detailsVC = segue.destinationViewController as? PokeDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.poke = poke
                }
            }
        }
    }


}

