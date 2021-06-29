//
//  ViewController.swift
//  PokeDex
//
//  Created by Irving Delgado Silva on 29/06/21.
//

import UIKit

class ViewController: UIViewController {

    private let presenter = PokemonPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presenter.setViewDelegate(delegate: self)
        presenter.fetchPokemons()
    }


}

//MARK: - PokemonPresenterDelegate methods

extension ViewController: PokemonPresenterDelegate
{
    func presentPokemons(pokemons: PokemonData) {
        print(pokemons.results)
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
        print(error)
    }
}

