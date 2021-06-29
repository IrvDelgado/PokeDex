//
//  Presenter.swift
//  PokeDex
//
//  Created by Irving Delgado Silva on 29/06/21.
//

import Foundation
import UIKit

protocol PokemonPresenterDelegate {
    //Functions that the controlloerv is going to conform to.
}

typealias PresenterDelegate = PokemonPresenterDelegate & UIViewController

class PokemonPresenter {
    
    weak var delegate: PresenterDelegate?
 
    public func setViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
}
