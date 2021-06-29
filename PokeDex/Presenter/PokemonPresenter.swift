//
//  PokemonPresenter.swift
//  PokeDex
//
//  Created by Irving Delgado Silva on 29/06/21.
// https://pokeapi.co/api/v2/pokemon?limit=500/

import Foundation
import UIKit

protocol PokemonPresenterDelegate {
    //Functions that the controlloerv is going to conform to.
    func presentPokemons(pokemons:PokemonData)
    func presentAlert(title: String, message: String)
    func didFailWithError(error: Error)
}

typealias PresenterDelegate = PokemonPresenterDelegate & UIViewController

class PokemonPresenter {
    
    weak var delegate: PresenterDelegate?
 
    public func setViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
    
    
    public func fetchPokemons() {
        //
        performRequest(urlstring: "https://pokeapi.co/api/v2/pokemon?limit=500/")
    }
    
    
    func performRequest(urlstring: String)  {
        
        //1. Create url
        
        if let url = URL(string: urlstring){
            
            //2. Create urlsession
            let urlsession = URLSession(configuration: .default)
            
            ///3.  Give the session a task
            let task = urlsession.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let Pokemons = self.parseJSON(safeData){
                        //self.delegate?.didUpdateWeather(self, weather: weather)
                        self.delegate?.presentPokemons(pokemons: Pokemons)
                    }
                }
            }
            
            //4. Start the task
            task.resume()
            
        }
    }
    
    func parseJSON(_ pokemonData: Data) -> PokemonData?{
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try  decoder.decode(PokemonData.self, from: pokemonData)
            
            
            //let pokemon = PokemonModel(conditionId: decodedData.weather[0].id, cityName: decodedData.name, temperature: decodedData.main.temp)
            
            let pokemons = PokemonData(results: decodedData.results)
            return pokemons
        
         }
        catch  {
            delegate?.didFailWithError(error: error)
            return nil
        }
       
    }
}
