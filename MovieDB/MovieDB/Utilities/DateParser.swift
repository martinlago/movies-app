//
//  DateParser.swift
//  MovieDB
//
//  Created by Martin Lago on 28/8/24.
//

import Foundation

extension String {
    
    /// Get year from date string following the format YYYY-MM-DD
    var yearFromDate: String? {
        return self.components(separatedBy: "-").first
    }
    
}
