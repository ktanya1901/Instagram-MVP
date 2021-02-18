//
//  MainViewPresenter.swift
//  Instagram-MVP
//
//  Created by Tatyana Korotkova on 17.02.2021.
//

import Foundation

protocol MainViewProtocol {
}

protocol MainViewPresenterProtocol {
    init(view: MainViewProtocol)
}

class MainViewPresenter: MainViewPresenterProtocol{
    let view: MainViewProtocol
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    
    
}
