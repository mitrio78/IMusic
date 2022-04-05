//
//  CMTime + Extension.swift
//  IMusic
//
//  Created by Mitrio on 05.04.2022.
//

import Foundation
import AVKit

extension CMTime {
    func toDisplayString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormattedString = String(format: "%02d:%02d", arguments: [minutes, seconds])
        return timeFormattedString
    }
}
