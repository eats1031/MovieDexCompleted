//
//  DateManager.swift
//  MovieDex
//
//  Created by Luis Becerra on 26/11/24.
//

import Foundation

extension String {
    func toMonthYearFormat() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM, yyyy"
            
            return outputFormatter.string(from: date)
        }
        return self
    }
    
    func toShortDateFormat() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM yyyy"
            
            return outputFormatter.string(from: date)
        }
        return self
    }
}
