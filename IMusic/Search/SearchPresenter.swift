//
//  SearchPresenter.swift
//  IMusic
//
//  Created by Mitrio on 04.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentData(response: Search.Model.Response.ResponseType) {
        switch response {
        case .presentTracks(let searchResults):
            let cells = searchResults?.results.map({ (track) in
                cellViewModel(from: track)
            }) ?? []
            print("Presenter.PresentTracks")
            let searchViewModel = SearchViewModel.init(cells: cells)
            viewController?.displayData(viewModel: .displayTracks(searchViewmodel: searchViewModel))
        case .presentFooterView:
            viewController?.displayData(viewModel: .displayFooterView)
        }
    }
    private func cellViewModel(from track: Track) -> SearchViewModel.Cell {
        return SearchViewModel.Cell.init(iconUrlString: track.artworkUrl100 ?? "",
                                         trackName: track.trackName,
                                         collectionName: track.collectionName ?? "",
                                         artistName: track.artistName,
                                         previewURL: track.previewUrl)
    }
}
