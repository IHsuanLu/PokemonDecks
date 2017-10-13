//
//  DetailVC.swift
//  pokedex
//
//  Created by 呂易軒 on 2017/10/4.
//  Copyright © 2017年 呂易軒. All rights reserved.
//

import UIKit

//＊we are going to do "LAZY LOADING"，在viewDidSelect做完、執行segue之後再下載API，不然一開始就下載會爆炸

//資料被傳過來，若不設定東西顯示，也看不出來
//可取用 = 傳遞成功
class DetailVC: UIViewController {
    
    //不用受限於init
    private var _pokeobj:Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var PokeImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    
    @IBOutlet weak var evolutionInfoLbl: UILabel!
    
    @IBOutlet weak var currentStatus: UIImageView!
    @IBOutlet weak var afterEvolution: UIImageView!
     
    
    //security
    var pokeobj:Pokemon{
        
        get{
            return _pokeobj
        } set {
            _pokeobj = newValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad() 

        pokeobj.downloadPokemonDetails {
            //whatever we write here will only be called after the network called is completed!
            

            //code to update/reload UI
            self.updateDetailUI()
        }
    }
    
    @IBAction func returnBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func updateDetailUI(){

        // 有在model寫getter這邊才抓得到！
        nameLbl.text = pokeobj.name.capitalized
        descriptionLbl.text = pokeobj.description
        PokeImg.image = UIImage(named: "\(pokeobj.id)")
        
        defenseLbl.text = pokeobj.defense
        attackLbl.text = pokeobj.attack
        heightLbl.text = pokeobj.height
        weightLbl.text = pokeobj.weight
        idLbl.text = "\(pokeobj.id)"
        typeLbl.text = pokeobj.type

        evolutionInfoLbl.text = pokeobj.evolutionInfoTxt
        currentStatus.image = UIImage(named: "\(pokeobj.id)")
        afterEvolution.image = UIImage(named: pokeobj.nextEvolutionId)
    }
    
}
