//
//  Double.swift
//  Sky
//
//  Created by Mars on 13/10/2017.
//  Copyright © 2017 Mars. All rights reserved.
//

import Foundation

extension Double {
    func toCelcius() -> Double {
        return (self - 32.0) / 1.8
    }
}
