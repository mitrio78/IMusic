//
//  TrackCell.swift
//  IMusic
//
//  Created by Mitrio on 05.04.2022.
//

import UIKit
import SDWebImage

protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}

class TrackCell: UITableViewCell {
    
    static let reuseID = "trackCell"
    var cell: SearchViewModel.Cell?
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var addTrackOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    func set(viewModel: SearchViewModel.Cell) {
        
        let savedTracks = UserDefaults.standard.savedTracks()
        let hasFavourite = savedTracks.first(where: { $0.trackName == self.cell?.trackName && $0.artistName == self.cell?.artistName}) != nil
        if hasFavourite {
            addTrackOutlet.isHidden = true
        } else {
            addTrackOutlet.isHidden = false
        }
        self.cell = viewModel
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url)
    }
    
    @IBAction func addTrack(_ sender: Any) {
        let defaults = UserDefaults.standard
        guard let cell = cell else { return }
        var listOfTracks = UserDefaults.standard.savedTracks()
        
        listOfTracks.append(cell)
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: listOfTracks, requiringSecureCoding: false) {
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
            print("Success")
            addTrackOutlet.isHidden = true
        }
    }
    
    @IBAction func temp(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        if let savedTrack = defaults.object(forKey: UserDefaults.favouriteTrackKey) as? Data {
            if let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTrack) as? [SearchViewModel.Cell] {
                decodedTracks.map { (track) in
                    print(track.trackName)
                }
            }
        }
    }
    
}
