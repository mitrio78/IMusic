//
//  Nib.swift
//  IMusic
//
//  Created by Mitrio on 05.04.2022.
//

import UIKit

extension UIView {
    
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
