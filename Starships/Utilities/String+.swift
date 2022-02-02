//
//  String+.swift
//  Starships
//
//  Created by Rahul Gunjote on 2/2/2022.
//

import Foundation

extension String {
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let dateString = self.components(separatedBy: ".").first {
          return dateFormatter.date(from:dateString)
        }
        return nil
    }
}

extension String {
    var floatValue: Float? {
        Float(self.replacingOccurrences(of: ",", with: ""))
    }
}
