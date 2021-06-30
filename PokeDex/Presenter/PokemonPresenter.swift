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
    //func presentPokemons(pokemons:[PokemonModel])
    func presentAlert(title: String, message: String)
    func didFailWithError(error: Error)
    func didFetchPokemon(pokemons: [Pokemon])
    func didFetchDetail(pokemonname: String, pokedetail: PokemonDetail)
  
}

typealias PresenterDelegate = PokemonPresenterDelegate & UIViewController

class PokemonPresenter {
    
    weak var delegate: PresenterDelegate?
 
    public func setViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
    
    
    

    public func fetchPokemons() {
        
        
        //1. Create url
        
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=500/"){
            
            //2. Create urlsession
            let urlsession = URLSession(configuration: .default)
            
            ///3.  Give the session a task
            let task = urlsession.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    //print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let Pokemons = self.parseJSON(safeData){
                        //self.delegate?.didUpdateWeather(self, weather: weather)
                        //self.delegate?.presentPokemons(pokemons: Pokemons)
                        self.delegate?.didFetchPokemon(pokemons: Pokemons.results)
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
    //PokemonModel
    
    

    
    public func fetchPokemonDetail(pokemon: Pokemon){
        //1. Create url
        //var detail = PokemonDetail(abilities: [], base_experience: 0, height: 0, id: -1, sprites: Sprite(front_default: ""), types: [], weight: 0)
        
        if let url = URL(string: pokemon.url){
            
            //2. Create urlsession
            let urlsession = URLSession(configuration: .default)
            
            ///3.  Give the session a task
            let task = urlsession.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    //print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let pokemondetail = self.parseDetail(safeData){
                        //self.delegate?.didUpdateWeather(self, weather: weather)
                        //self.delegate?.presentPokemons(pokemons: Pokemons)
                        //Retornar Detail
                        
                        self.delegate?.didFetchDetail(pokemonname: pokemon.name, pokedetail: pokemondetail)
                        //print(detail)
                    }
                }
                
            }
            
            //4. Start the task
            task.resume()
            
        }
        
    }
    
    func parseDetail(_ pokemondetailData: Data) -> PokemonDetail?{
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try  decoder.decode(PokemonDetail.self, from: pokemondetailData)
            
            
            //let pokemon = PokemonModel(conditionId: decodedData.weather[0].id, cityName: decodedData.name, temperature: decodedData.main.temp)
            
            let pokemondetail = PokemonDetail(abilities: decodedData.abilities, base_experience: decodedData.base_experience, height: decodedData.height, id: decodedData.id, sprites: decodedData.sprites, types: decodedData.types, weight: decodedData.weight)
            
            return pokemondetail
        
         }
        catch  {
            delegate?.didFailWithError(error: error)
            return nil
        }
       
    }
}
