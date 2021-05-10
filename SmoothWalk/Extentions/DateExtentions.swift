//
//  DateExtentions.swift
//  SmoothWalk
//
//  Created by kaveh mohammadpour on 5/9/21.
//

import Foundation

extension Date {
    
    var weekdayString: String {
        
        let weekDayMapping = Calendar.current.shortWeekdaySymbols
        let weekDay = Calendar.current.component(.weekday, from: self)
        return weekDayMapping[weekDay-1]
    }
    
    var weekOfYearString: String {
        let weekOfYear =  Calendar.current.component(.weekOfYear, from: self)
        return "\(weekOfYear-1)"
    }
    
    var shortMonthNameString : String {
        let monthMapping = Calendar.current.veryShortMonthSymbols
        let month =  Calendar.current.component(.month, from: self)
        return monthMapping[month-1]
    }
    
    static func anchorDay(_ timeOffset:Int) -> Date {
        let calendar: Calendar = .current
        var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: Date())
        let offset = (7 + (anchorComponents.weekday ?? 0) - 2) % 7
        
        anchorComponents.day! -= offset
        anchorComponents.hour = timeOffset
        
        let anchorDate = calendar.date(from: anchorComponents)!
        
        return anchorDate
    }
    
}
