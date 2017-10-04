//
//  Pokemon.swift
//  pokedex
//
//  Created by 呂易軒 on 2017/9/28.
//  Copyright © 2017年 呂易軒. All rights reserved.
//

import Foundation

class Pokemon{
    
    fileprivate var _name:String!
    fileprivate var _id:Int!
    
    var name:String{
        if _name == nil{
            _name = ""
        }
        
        return _name
    }
    
    var id:Int{
        if _id == nil{
            _id = 0
        }
        
        return _id
    }
    
    //we need to be able to initialize ezch pokemon object
    //之前試用Alamofire下載下來之後 'self.XXX = XXX'
    //init可以直接做這件事
    
    init(name: String, id: Int){
        
        self._name = name
        self._id = id
    }
}
