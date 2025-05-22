//
//  String + Extension.swift
//  WeatherTest
//
//  Created by Евгений Таракин on 23.05.2025.
//

import Foundation

extension String {
    func getHour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: self) ?? Date()
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        var stringHour = String(hour)
        if hour / 10 == 0 {
            stringHour = "0" + stringHour
        }
        
        return stringHour
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self) ?? Date()
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "dd.MM"
        let newDate = newDateFormatter.string(from: date)
        
        return newDate
    }
}
