//
//  ViewController.swift
//  pokedex
//
//  Created by 呂易軒 on 2017/9/27.
//  Copyright © 2017年 呂易軒. All rights reserved.
//

import UIKit
import AVFoundation

// implement protocols
class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    //和tableView一樣，collectionView也要IBOutlet, 之後protocols的func和viewDidLoad會要用到
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var sliderBar: UISlider!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pokemons = [Pokemon]()
    var pokemonIsSearching = [Pokemon]()

    var whetherInSearchMode:Bool = false //by default
    
    var musicPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        //直接篩選，所以把search改成done
        
        parsePokeonCSV()
        initAudio()
    }
    
    // required functions
    // similar to 'cell for row at' (2的必要)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            // 把indexPath.row的obj(Reuseable Cell)放到configure func(set Lbl的func）
            let poke :Pokemon!
            
            if whetherInSearchMode == true {
                
                poke = pokemonIsSearching[indexPath.row]
                
            } else {
                
                poke = pokemons[indexPath.row]
            }
            
            cell.configureCell(poke)
            
            return cell
        } else {
            
            print("It's not working")
            // an empty generic cell
            return UICollectionViewCell()
        }
    }
    
    // when you select the cell you want it to do something（1的可要）
    // in this case, trigger the segue to change the page
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let poke :Pokemon!

        if whetherInSearchMode == true{
        
            poke = pokemonIsSearching[indexPath.row]

        } else {
            
            poke = pokemons[indexPath.row]
        }
        
        //sender: what we want to send to 'identifier'， 此時要在Detail也new一個Pokemon的Object for it to be sent into
        performSegue(withIdentifier: "DetailVC", sender: poke)
    }

    // return how many objects in the collection view right now（2的必要）
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if whetherInSearchMode == true {
            
            return pokemonIsSearching.count
        }
        
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
            
            //try後面不一定是{}，也是可是這樣，順邊assign
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
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        //pausing and unpausing
        if musicPlayer.isPlaying{
            
            musicPlayer.pause()
            sliderBar.isHidden = true
            sender.alpha = 0.3 //指UIButton(正在被控制的)
        } else {
           
            musicPlayer.play()
            sliderBar.isHidden = false
            sender.alpha = 1.0
        }
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        let volumeVal = Float(sender.value)
        musicPlayer.volume = volumeVal
    }
    
    //music
    func initAudio(){
        
        //we need a path to music file
        let path = Bundle.main.path(forResource: "remix", ofType: "mp3")!
    
        do{
            //用Bundle抓到的是String(contentsOf要String就直接放path；要URL就要改)
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            
            //隨時準備播放
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1 //continuously
            musicPlayer.play() //play automatically
        
        }catch let err as NSError{
            
            print("audio doesn't work")
            print(err.debugDescription)
        }
    }
    
    //we need a func that will check for each time a keystrke is made
    //we need protocol!!! 'UISearchBarDelegate'
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //什麼都沒打的時候出現全部：pokemons array
        //逐一篩選：需要另一個array
        
        //是不是在search mode?
        if searchBar.text == nil || searchBar.text == "" {
            
            //定義searchMode
            whetherInSearchMode = false
            collection.reloadData()
            
            view.endEditing(true) // let the keyboard go away
            
        } else {
            
            whetherInSearchMode = true
            
            //想法：
            //把在searchBar的keyStroke和所有的pokemon name做比較
            //若keystroke被涵蓋在某名字內，則把某名字放到pokemonIsSearching中 然後顯示該array
            //所有有關pokemons的地方都要加上 if- 如果在searchMode的時候。。。
            
            //$0 is a placeholder of any and all of the objects in 'pokemons'
            // it based on whether the searchBar text is included in the range of origin name
            let lower = searchBar.text!.lowercased()
            pokemonIsSearching = pokemons.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true) // let the keyboard go away
    }
    
    //prepare for 'perform segue'
    //this happen before the seque(viewDidLoad of DetailVC)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //萬一不只一個identifier
        if segue.identifier == "DetailVC"{
            
            //if we found the destination view controller
            if let destination = segue.destination as? DetailVC{
            
                //if there is a sender and its type is Pokemon? （sender = what you want to send）
                //if yes, assign it to poke
                if let poke = sender as? Pokemon{
                    
                    //pokeobj is the object we create in the destination
                    destination.pokeobj = poke
                }  
            }
        }
    }
}

