//
//  String+Ext.swift
//  GithubFollowers
//
//  Created by Jun Hyeok Kim on 7/10/24.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_posix")
        
        return dateFormatter.date(from: self)
    }
    
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else {return "N/A"}
        return date.convertToMonthYearFormat()
    }
      
}
