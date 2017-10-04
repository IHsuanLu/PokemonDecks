//
//  ViewController.swift
//  pokedex
//
//  Created by 呂易軒 on 2017/9/27.
//  Copyright © 2017年 呂易軒. All rights reserved.
//

import UIKit

// implement protocols
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //和tableView一樣，collectionView也要IBOutlet, 之後protocols的func和viewDidLoad會要用到
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemons = [Pokemon]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        parsePokeonCSV()
    }
    
    // required functions
    // similar to 'cell for row at' (2的必要)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            // 把indexPath.row的obj(Reuseable Cell)放到configure func(set Lbl的func）
            let pokeArray = pokemons[indexPath.row]
            cell.configureCell(pokeArray)
            
            return cell
        } else {
            
            print("It's not working")
            // an empty generic cell
            return UICollectionViewCell()
        } 
    }
    
    // when you select the cell you want it to do something（1的可要）
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    // return how many objects in the collection view right now（2的必要）
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pokemons.count
    }
    
    // (2的可要)
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    
        return 1
    }
    
    // set the size(3的可要)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    
    
    //create a function that will parse the Pokemon CSV data and put it into a form that is useful to us
    func parsePokeonCSV(){
        
        // all we need to do is grab and parse
        // grab
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        // use the parser 有風險所以要do catch(系統有說要throws 就是要用do catch)
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            //確定有取到csv的值，拿我們要的
            for row in rows{
            
                //把csv檔裡面的每個id轉換成Int assign到pokeID
                let pokeID = Int(row["id"]!)!
                let pokeName = row["identifier"]!
                
                //用抓到的值new一個Object，再append到Pokemon形態的array(pokemons)
                let pokemonobjForArray = Pokemon(name: pokeName, id: pokeID)
                pokemons.append(pokemonobjForArray)
            }
            
            
        } catch let err as NSError {
            print("csv doesn't work")
            print(err.debugDescription)
        }
    }
}

