//
//  Calendar+date.swift
//  SchoolNewsLetter
//
//  Created by 은석준 on 2020/05/04.
//  Copyright © 2020 Jay Lee. All rights reserved.
//

import Foundation

extension Calendar {
    func date(from rawDate: String) -> Date? {
        guard
            let intDate = Int(rawDate),
            (10_000_000..<100_000_000).contains(intDate)
            else { return nil }
        
        let year = intDate / 10000
        let month = intDate / 100 % 100
        let day = intDate % 100
        
        let dateComponents = DateComponents(
            calendar: self,
            year: year,
            month: month,
            day: day
        )
        
        return date(from: dateComponents)
    }
}
