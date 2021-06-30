//
//  DetailViewController.swift
//  PokeDex
//
//  Created by Irving Delgado Silva on 29/06/21.
//

import UIKit

class DetailViewController: UIViewController {

    var pokemonmodel: PokemonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        if let poke = pokemonmodel{
            print(poke)
        }
        else{
            print("Nil")
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
