//
//  SearchInteractor.swift
//  IMusic
//
//  Created by Mitrio on 04.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
    
    var networkService = NetworkService()
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        switch request {
        case .getTracks(let searchTerm):
            print("Interactor.GetTracks")
            presenter?.presentData(response: .presentFooterView)
            networkService.fetchTracks(searchText: searchTerm) { [weak self] (searchResponse) in
                self?.presenter?.presentData(response: .presentTracks(searchResponse: searchResponse))
            }
        }
    }
}
