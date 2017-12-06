//
//  Pokemon.swift
//  pokedex
//
//  Created by 呂易軒 on 2017/9/28.
//  Copyright © 2017年 呂易軒. All rights reserved.
//

import UIKit
import Alamofire
// if there is an error, then press shift+command+K and then S+C+b


class Pokemon{
    
    private var _name: String!
    private var _id: Int!
    private var _description: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _baseExp: String!
    private var _ability: String!
    private var _evolutionInfoTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    
    // 原本要打在Constant的，但是因為需要id所以在這裡組成
    private var _POKEMON_URL: String!
    private var _ABILITY_URL: String!
    private var _EVOLUTION_URL: String!
     
    var name: String{
       
        if _name == nil{
            _name = ""
        }
        
        return _name
    }
    
    var id: Int{
       
        if _id == nil{
            _id = 0
        }
        
        return _id
    }
    
    var description: String{
       
        if _description == nil{
            _description = ""
        }
        
        return _description
    }
    
    var type: String{
        
        if _type == nil{
            _type = ""
        }
        
        return _type
    }
    
    var baseExp: String{
        
        if _baseExp == nil{
            _baseExp = ""
        }
        
        return _baseExp
    }
    
    var ability: String{
        
        if _ability == nil{
            _ability = ""
        }
        
        return _ability
    }
    
    var height: String{
       
        if _height == nil{
            _height = ""
        }
        
        return _height
    }
    
    var weight: String{
        
        if _weight == nil{
            _weight = ""
        }
        
        return _weight
    }
    
    var evolutionInfoTxt: String{
       
        if _evolutionInfoTxt == nil{
            _evolutionInfoTxt = ""
        }
        
        return _evolutionInfoTxt
    }
    
    var nextEvolutionName: String{
        
        if _nextEvolutionName == nil{
            _nextEvolutionName = ""
        }
        
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String{
        
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        
        return _nextEvolutionId
    }
    
    var evoGroup: Int{
        
        switch id {
        case 1, 2, 3:
            return 1
        case 4, 5, 6:
            return 2
        case 7, 8, 9:
            return 3
        case 10, 11, 12:
            return 4
        case 13, 14, 15:
            return 5
        case 16, 17, 18:
            return 6
        case 19, 20:
            return 7
        case 21, 22:
            return 8
        case 23, 24:
            return 9
        case 25, 26:
            return 10
        case 27, 28:
            return 11
        case 29, 30, 31:
            return 12
        case 32, 33, 34:
            return 13
        case 35, 36:
            return 14
        case 37, 38:
            return 15
        case 39, 40:
            return 16
        case 41, 42:
            return 17
        case 43, 44, 45:
            return 18
        case 46, 47:
            return 19
        case 48, 49:
            return 20
        case 50, 51:
            return 21
        case 52, 53:
            return 22
        case 54, 55:
            return 23
        case 56, 57:
            return 24
        case 58, 59:
            return 25
        case 60, 61, 62:
            return 26
        case 63, 64, 65:
            return 27
        case 66, 67, 68:
            return 28
        case 69, 70, 71:
            return 29
        case 72, 73:
            return 30
        case 74, 75, 76:
            return 31
        case 77, 78:
            return 32
        case 79, 80:
            return 33
        case 81, 82:
            return 34
        case 83:
            return 35
        case 84, 85:
            return 36
        case 86, 87:
            return 37
        case 88, 89:
            return 38
        case 90, 91:
            return 39
        case 92, 93, 94:
            return 40
        case 95:
            return 41
        case 96, 97:
            return 42
        case 98, 99:
            return 43
        case 100, 101:
            return 44
        case 102, 103:
            return 45
        case 104, 105:
            return 46
        case 106, 107:
            return 47
        case 108:
            return 48
        case 109, 110:
            return 49
        case 111, 112:
            return 50
        case 113:
            return 51
        case 114:
            return 52
        case 115:
            return 53
        case 116, 117:
            return 54
        case 118, 119:
            return 55
        case 120, 121:
            return 56
        case 122:
            return 57
        case 123:
            return 58
        case 124:
            return 59
        case 125:
            return 60
        case 126:
            return 61
        case 127:
            return 62
        case 128:
            return 63
        case 129, 130:
            return 64
        case 131:
            return 65
        case 132:
            return 66
        case 133, 134, 135, 136:
            return 67
        case 137:
            return 68
        case 138, 139:
            return 69
        case 140, 141:
            return 70
        case 142:
            return 71
        case 143:
            return 72
        case 144:
            return 73
        case 145:
            return 74
        case 146:
            return 75
        case 147, 148, 149:
            return 76
        case 150:
            return 77
        case 151:
            return 78
        default:
            return 0
        }
    }
    
    //we need to be able to initialize each pokemon object
    //之前試用Alamofire下載下來之後 'self.XXX = XXX'
    //init可以直接做這件事
    
    init(name: String, id: Int){
        
        self._name = name
        self._id = id
        
        //_POKEMON_URL是各種id的URL的集合
        self._POKEMON_URL = "\(BASE_URL)\(VERSION_URL)\(self.id)/"
        self._ABILITY_URL = "\(BASE_URL)\(ABILITY_URL)\(self.id)"
        self._EVOLUTION_URL = "\(BASE_URL)\(EVOLUTION_URL)\(self.evoGroup)"
    }
    
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
        
        let pokemonURL = URL(string: _POKEMON_URL)!
        let abilityURL = URL(string: _ABILITY_URL)!
        let evolutionURL = URL(string: _EVOLUTION_URL)! 

            
        Alamofire.request(evolutionURL).responseJSON{ response in
          
            let result = response.result
                
            if let dictionary = result.value as? Dictionary<String, AnyObject>{
                    
                if let chain = dictionary["chain"] as? Dictionary<String, AnyObject> {
                        
                    if let species1 = chain["species"] as? Dictionary<String, AnyObject> {
                            
                        if let name1 = species1["name"] as? String{
                                
                            if name1 == self._name {
                                
                                if let evolves_to1 = chain["evolves_to"] as? [Dictionary<String, AnyObject>], evolves_to1.isEmpty == false {
                                    
                                    if let species2 = evolves_to1[0]["species"] as? Dictionary<String, AnyObject> {
                                        
                                        if let nextEvoName = species2["name"] as? String{
                                            
                                            self._nextEvolutionName = nextEvoName
                                            self._evolutionInfoTxt = "Next  Evolution:  \(self.nextEvolutionName.capitalized)"
                                            self._nextEvolutionId = "\(self.id + 1)"
                                        }
                                    }
                                    
                                } else {
                                    
                                    self._evolutionInfoTxt = "There  is  no  Evolution."
                                }
                                
                            } else {
                                
                                if let evolves_to1 = chain["evolves_to"] as? [Dictionary<String, AnyObject>] {
                                    
                                    if let evolves_to2 = evolves_to1[0]["evolves_to"] as? [Dictionary<String, AnyObject>], evolves_to2.isEmpty == false {
                                        
                                        
                                        if let species3 = evolves_to2[0]["species"] as? Dictionary<String, AnyObject>{
                                                
                                            if let nextEvoName2 = species3["name"] as? String{
                                                
                                                if nextEvoName2 != self._name{
                                                    
                                                    self._nextEvolutionName = nextEvoName2
                                                    self._evolutionInfoTxt = "Next  Evolution:  \(self.nextEvolutionName.capitalized)"
                                                    self._nextEvolutionId = "\(self.id + 1)"
                                                    
                                                } else {
                                                    
                                                    self._evolutionInfoTxt = "There  is  no  Evolution."
                                                }
                                            }
                                                
                                        } else {
                                                
                                            self._evolutionInfoTxt = "There  is  no  Evolution."
                                        }
                            
                                    } else {
                                    
                                        self._evolutionInfoTxt = "There  is  no  Evolution."
                                    }

                                } else {
                                        
                                    self._evolutionInfoTxt = "There  is  no  Evolution."
                                }

                            }
                        }
                            
                    }
                }
            }
                
            // 都做完了但是東西顯示不出來！ 可能是忘了completed！
            completed() // URL裡面的東西下載完之後，func complete 即停止
        }
        
       
        
        
        Alamofire.request(abilityURL).responseJSON{ response in
            
            let result = response.result

            if let dictionary = result.value as? Dictionary<String, AnyObject> {
                
                if let effect_entries = dictionary["effect_entries"] as? [Dictionary<String, AnyObject>] {
                    
                    if let short_effect = effect_entries[0]["short_effect"] as? String{
                        
                        self._description = short_effect
                    }
                }
            }
            
            // 都做完了但是東西顯示不出來！ 可能是忘了completed！
            completed() // URL裡面的東西下載完之後，func complete 即停止
        }
        
        
        Alamofire.request(pokemonURL).responseJSON{ response in
        
            let result = response.result
            // 到此以前，確定JSON是可以被成功下載下來的
            
            // 接下來就是要抓出JSON裡面我們所需要的部分
            if let dictionary = result.value as? Dictionary<String, AnyObject>{
                
                if let baseExp = dictionary["base_experience"] as? Int{
                
                    self._baseExp = "\(baseExp)"
                }
                
                if let weight = dictionary["weight"] as? Int{
                    
                    self._weight = "\(weight)"
                }
                
                if let height = dictionary["height"] as? Int{
                    
                    self._height = "\(height)"
                }
                
                //',' 後面是接 additional constraints
                if let types = dictionary["types"] as? [Dictionary<String, AnyObject>], types.count > 0 {
                    
                    //若type只有一個
                    if let type = types[0]["type"] as? Dictionary<String, AnyObject>{
                        
                        if let name = type["name"] as? String{
                        
                            self._type = name.capitalized
                        }
                    }
                    
                    //若type多於一個
                    if types.count > 1{
                    
                        for i in 1..<types.count{
                            
                            if let type = types[i]["type"] as? Dictionary<String, AnyObject>{
                            
                                if let name = type["name"] as? String{
                                
                                    //String也可以直接用加的加在後面
                                    self._type = self._type + "/\(name.capitalized)"
                                }
                            }
                        }
                    }
                    
                } else {
                    
                    self._type = "UNKNOWN"
                }
                
                
                if let abilities = dictionary["abilities"] as? [Dictionary<String, AnyObject>], abilities.count > 0 {
                    
                        if let ability = abilities[0]["ability"] as? Dictionary<String, AnyObject>{
                        
                            if let name = ability["name"] as? String{
                            
                                self._ability = name.capitalized
                            }
                    }
                    
                    
                } else {
                    
                    self._type = "UNKNOWN"
                }
                
            }
            completed() // URL裡面的東西下載完之後，func complete 即停止
        }
    }
}
