//
//  UserDefaults.swift
//  IMusic
//
//  Created by Mitrio on 07.04.2022.
//

import Foundation

extension UserDefaults {
    static let favouriteTrackKey = "favouriteTrackKey"
    
    func savedTracks() -> [SearchViewModel.Cell] {
        let defaults = UserDefaults.standard
        
        guard let savedtracks = defaults.object(forKey: UserDefaults.favouriteTrackKey) as? Data else { return [] }
        guard let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedtracks) as? [SearchViewModel.Cell] else { return []}
        return decodedTracks
    }
}
