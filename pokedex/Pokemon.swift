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
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _evolutionInfoTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionLvl: String!
    private var _nextEvolutionId: String!
    
    // 原本要打在Constant的，但是因為需要id所以在這裡組成
    private var _POKEMON_URL: String!
     
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
    
    var defense: String{
        
        if _defense == nil{
            _defense = ""
        }
        
        return _defense
    }
    
    var attack: String{
        
        if _attack == nil{
            _attack = ""
        }
        
        return _attack
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
    
    var nextEvolutionLvl: String{
        
        if _nextEvolutionLvl == nil{
            _nextEvolutionLvl = ""
        }
        
        return _nextEvolutionLvl
    }
    
    var nextEvolutionId: String{
        
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        
        return _nextEvolutionId
    }
    
    //we need to be able to initialize ezch pokemon object
    //之前試用Alamofire下載下來之後 'self.XXX = XXX'
    //init可以直接做這件事
    
    init(name: String, id: Int){
        
        self._name = name
        self._id = id
        
        //_POKEMON_URL是各種id的URL的集合
        self._POKEMON_URL = "\(BASE_URL)\(VERSION_URL)\(self.id)/"
    }
    
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
    
        let pokemonURL = URL(string: _POKEMON_URL)!
        
        Alamofire.request(pokemonURL).responseJSON{ (response) in
        
            let result = response.result
            
            // 到此以前，確定JSON是可以被成功下載下來的
            
            // 接下來就是要抓出JSON裡面我們所需要的部分
            if let dictionary = result.value as? Dictionary<String, AnyObject>{
                
                if let attack = dictionary["attack"] as? Int{
                
                    self._attack = "\(attack)"
                }
                
                if let defense = dictionary["defense"] as? Int{
                    
                    self._defense = "\(defense)"
                }
                
                if let weight = dictionary["weight"] as? String{
                    
                    self._weight = weight
                }
                
                if let height = dictionary["height"] as? String{
                    
                    self._height = height
                }
                
                //',' 後面是接 additional constraints
                if let types = dictionary["types"] as? [Dictionary<String, AnyObject>], types.count > 0 {
                    
                    //若type只有一個
                    if let name = types[0]["name"] as? String{
                        
                        self._type = name.capitalized
                    }
                    
                    //若type多於一個
                    if types.count > 1{
                    
                        for i in 1..<types.count{
                            
                            if let name = types[i]["name"] as? String{
                                
                                //String也可以直接用加的加在後面
                                self._type = self._type + "/\(name.capitalized)"
                            }
                        }
                    }
                    
                } else {
                    
                    self._type = "UNKNOWN"
                }
                
                
                if let descriptions = dictionary["descriptions"] as? [Dictionary<String, AnyObject>], descriptions.count > 0 {
                    
                    //to get the URL that we are going to follow(the first one)
                    if let url = descriptions[0]["resource_uri"] as? String{
                        
                        let descriptionURL = URL(string: "\(BASE_URL)\(url)")!
                        
                        //讓alamofire到那邊取值
                        Alamofire.request(descriptionURL).responseJSON{ (response) in
                            
                            // this is inevitible
                            let result = response.result
                            
                            if let decriptionDictionary = result.value as? Dictionary<String, AnyObject>{
                                
                                if let description = decriptionDictionary["description"] as? String{
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._description = newDescription
                                    print(self._description)
                                }
                            }
                            // 都做完了但是東西顯示不出來！ 可能是忘了completed！
                            completed() // URL裡面的東西下載完之後，func complete 即停止
                        }
                    }
                } else {
                    
                    self._description = ""
                }
                
                if let evolutions = dictionary["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.isEmpty == false{
                    
                    if let nextEvoName = evolutions[0]["to"] as? String{
                        
                        //沒有mega才做(看assets的範圍到哪，之前把mega進化的神奇寶貝都刪掉了)
                        if nextEvoName.range(of: "-mega") == nil{
                            
                            self._nextEvolutionName = nextEvoName
                            print(self.nextEvolutionName)
                            
                            
                            //不用再呼叫一次Alamofire.request，因為uri裡面有說了id
                            //為了不希望有mega形態的神奇寶貝，所以放進來
                            if let nextEvoUri = evolutions[0]["resource_uri"] as? String{
                                
                                let IdExtraction = nextEvoUri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = IdExtraction.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvoId
                                print(self.nextEvolutionId)

                            }
                            
                            
                            //為了不希望有mega形態的神奇寶貝，所以放進來
                            if let nextEvoLvl = evolutions[0]["level"] as? Int{
                                
                                self._nextEvolutionLvl = "\(nextEvoLvl)"
                                print(self.nextEvolutionLvl)
                                
                            } else {
                                
                                self._nextEvolutionLvl = "Unknown"
                            }
                            
                            
                            self._evolutionInfoTxt = "Next  Evolution:  \(self.nextEvolutionName)  LVl:\(self.nextEvolutionLvl)"
                            
                            print(self.evolutionInfoTxt)
                            

                        } else {
                            
                            self._evolutionInfoTxt = "There  is  no  Evolution."
                            print(self.evolutionInfoTxt)
                        }
                    }
                    
                } else {
                    
                    self._evolutionInfoTxt = "There is no Evolution"
                    print(self.evolutionInfoTxt)

                }
            }
            completed() // URL裡面的東西下載完之後，func complete 即停止
        }
    }
}
