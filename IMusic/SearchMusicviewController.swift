//
//  SearchviewController.swift
//  IMusic
//
//  Created by Mitrio on 04.04.2022.
//

import UIKit
import Alamofire

struct TrackModel {
    var trackName: String
    var artistName: String
}

class SearchMusicviewController: UITableViewController {
    
    private var timer: Timer?
    let searchController = UISearchController(searchResultsController: nil)
    var tracks: [Track] = []
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
            
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    //MARK: Configuring cells
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = "\(tracks[indexPath.row].trackName) \n\(tracks[indexPath.row].artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = UIImage(named: "cover")
        return cell
    }
}

// MARK: SearchBar Delegate

extension SearchMusicviewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { timer in
            self.networkService.fetchTracks(searchText: searchText) { [unowned self] searchResults in
                self.tracks = searchResults?.results ?? []
                self.tableView.reloadData()
            }
        })
    }
}
