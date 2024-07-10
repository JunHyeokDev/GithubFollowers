//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/10/24.
//

import Foundation


extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }

    
}
