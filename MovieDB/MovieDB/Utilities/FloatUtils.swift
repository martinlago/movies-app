//
//  FloatUtils.swift
//  MovieDB
//
//  Created by Martin Lago on 29/8/24.
//

import Foundation

// MARK: - Float utilities

extension Float {
    
    var oneDecimal: Float {
        return (self * 10).rounded() / 10
    }
}
