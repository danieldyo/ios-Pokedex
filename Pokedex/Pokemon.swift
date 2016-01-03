//
//  Pokemon.swift
//  Pokedex
//
//  Created by Home on 12/30/15.
//  Copyright © 2015 DanielOng. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _Id: Int!
    private var _desc: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseatk: String!
    private var _nextEvoTxt: String!
    private var _nextEvoId: String!
    private var _nextEvoLvl: String!
    private var _PokeURL: String!
    
    var name: String {
        if _name == nil {
            return ""
        }
        return _name
    }
    
    var Id: Int {
        return _Id
    }
    
    var desc: String {
        if _desc == nil {
            return ""
        }
        return _desc
    }
    
    var type: String {
        if _type == nil {
            return ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            return ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            return ""
        }
        return _weight
    }
    
    var baseatk: String {
        if _baseatk == nil {
            return ""
        }
        return _baseatk
    }
    
    var nextEvoTxt: String {
        if _nextEvoTxt == nil {
            return ""
        }
        return _nextEvoTxt
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            return ""
        }
        return _nextEvoId
    }
    
    var nextEvoLvl: String {
        if _nextEvoLvl == nil {
            return ""
        }
        return _nextEvoLvl
    }
    
    var PokeURL: String! {
        if _PokeURL == nil {
            return ""
        }
        return _PokeURL
    }
    
    init(name: String, Id: Int) {
        self._name = name
        self._Id = Id
        self._PokeURL = "\(URL_BASE)\(URL_POKEMON)\(self._Id)/"
    }
    
    func downloadDetails(completed: DownloadComplete) {
        let url = NSURL(string: _PokeURL)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            //print(result.value?.debugDescription)
            // parse thru json
            if let dict = result.value as? Dictionary<String, AnyObject> {
                // converts json into a dictionary
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._baseatk = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                //print(self._weight)
                //print(self._height)
                //print(self._baseatk)
                //print(self._defense)
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                        
                    if let name = types[0]["name"] {
                        self._type = name
                    }
                    
                    if types.count > 1 {
                        for var i = 1; i < types.count; i++ {
                            if let name = types[i]["name"] {
                                self._type! += "/\(name)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
               //print(self._type)
                
                if let descArray = dict["descriptions"] as? [Dictionary<String, String>] where descArray.count > 0 {
                    if let url = descArray[0]["resource_uri"] {
                        let NSurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, NSurl).responseJSON { response in
                            let result2 = response.result
                            if let descDict = result2.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._desc = description.stringByReplacingOccurrencesOfString("POKMON", withString: "Pokemon")
                                }
                            }
                            completed()
                            // says the download is complete
                    }
                    
                } else {
                    self._desc = ""
                }
                    if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>]
                        where evolutions.count > 0 {
                            if let evol = evolutions[0]["to"] as? String {
                                if evol.rangeOfString("mega") == nil {
                                    if let str = evolutions[0]["resource_uri"] as? String {
                                        let newStr = str.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                        let evolNum = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                        self._nextEvoId = evolNum
                                        self._nextEvoTxt = evol
                                        
                                        if let lvl = evolutions[0]["level"] as? Int {
                                            self._nextEvoLvl = "\(lvl)"
                                        }
                                        
                                       //print(self._nextEvoLvl)
                                       // print(self._nextEvoTxt)
                                       //print(self._nextEvoId)
                                    }
                                }
                            }
                    }
                    
                    
                
            }
        }
    }
    
 }
}