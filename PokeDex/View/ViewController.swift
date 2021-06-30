//
//  ViewController.swift
//  PokeDex
//
//  Created by Irving Delgado Silva on 29/06/21.
//

import UIKit

class ViewController: UIViewController {

    private let presenter = PokemonPresenter()
    private var PokemonList = [PokemonModel]()
    private var currentindx:Int = -1
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        
        tableView.delegate = self
        presenter.setViewDelegate(delegate: self)
        presenter.fetchPokemons()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let DetailVC = segue.destination as? DetailViewController else {
            return
        }
        
        if(currentindx != -1){
            print("******************")
            print(currentindx)
            print(PokemonList[currentindx])
            DetailVC.pokemonmodel = PokemonList[currentindx]
        }
        else {
            print("orale")
        }
    }


}

//MARK: - PokemonPresenterDelegate methods

extension ViewController: PokemonPresenterDelegate
{
    func didFetchDetail(pokemonname: String, pokedetail: PokemonDetail) {
        PokemonList.append(PokemonModel(name:pokemonname, detail: pokedetail))
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexp = IndexPath(row: self.PokemonList.count-1, section: 0)
            
           // self.tableView.scrollToRow(at: indexp, at: .top, animated: true)
        }
    }
    

    
    func didFetchPokemon(pokemons: [Pokemon]) {
        
        //Fetch Pokemon details
        for pokemon in pokemons {
            presenter.fetchPokemonDetail(pokemon: pokemon)
        }
        
        print("___________________________________________________________________")
        print(PokemonList)
    }
    
    


    
    func presentAlert(title: String, message: String) {
        print("Gotta catch 'em all")
    }
    
    /*
    func didUpdateWeather(_ weathermanager: WeatherManager, weather: WeatherModel) {
        print(weather.temperature)
        
        DispatchQueue.main.async {
            
            self.temperatureLabel.text = weather.temperatureString
            
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
    }
    */
    
    func didFailWithError(error: Error) {
        //print(error)
    }
}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = PokemonList[indexPath.row].name
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) //as! MessageCell

        /*
        //If message from the current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        */
        
        cell.textLabel?.text = message
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentindx = indexPath.row
        
        performSegue(withIdentifier: "MySegue", sender: self)
        //print(indexPath.row)
        //print(PokemonList[indexPath.row])
    }
}
