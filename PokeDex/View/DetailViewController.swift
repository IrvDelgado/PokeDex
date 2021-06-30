//
//  DetailViewController.swift
//  PokeDex
//
//  Created by Irving Delgado Silva on 29/06/21.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class DetailViewController: UIViewController {

    var pokemonmodel: PokemonModel?
    
    @IBOutlet weak var namelbl: UILabel!
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var abilitieslbl: UILabel!
    
    @IBOutlet weak var baseexplbl: UILabel!
    
    @IBOutlet weak var weightlbl: UILabel!
    
    @IBOutlet weak var typeslbl: UILabel!
    @IBOutlet weak var idlbl: UILabel!
    @IBOutlet weak var heightlbl: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

       
        if let poke = pokemonmodel{
            //print(poke)
            imageV.contentMode = .scaleAspectFill
            imageV.downloaded(from: poke.detail.sprites.front_default)
            namelbl.text = poke.name
            
            abilitieslbl.text = poke.detail.abilities[0].ability.name
            
            baseexplbl.text = String(poke.detail.base_experience)
            
            heightlbl.text = String(poke.detail.height)
            
            idlbl.text = String(poke.detail.id)
            
            typeslbl.text = poke.detail.types[0].type.name
            
            weightlbl.text = String(poke.detail.weight)
            
            
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
