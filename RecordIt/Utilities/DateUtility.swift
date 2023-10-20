//
//  DateUtility.swift
//  Lisa-Marie-Schiffner-App
//
//  Created by Mac on 12/10/22.
//  Copyright © 2022 Codemenschen GmbH- Codemenschen.at. All rights reserved.
//

import Foundation

struct DateUtility {
    static func convertDateInString(_ date: Date, dateFormat: String = Constants.dateFormatConversion, timeZoneValue: TimeZone? = NSTimeZone(name: Constants.timeZoneAbreviation) as TimeZone?) -> String {

        let dateFormatter = DateFormatter()
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? Constants.localeIdentifier }
        dateFormatter.locale = NSLocale(localeIdentifier: localTimeZoneAbbreviation) as Locale?
        dateFormatter.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation)
        dateFormatter.dateFormat = dateFormat
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    static func dateTimeForDB(_ strDate: String, strFormat: String = Constants.dateModifyFormatter) -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = strFormat
        let date = dateFormat.date(from: strDate)
        return date
    }

    static func calculateDateDifference(start: Date, end: Date) -> String? {
        let form = DateComponentsFormatter()
        form.unitsStyle = .abbreviated
        form.allowedUnits = [.second, .minute, .hour]
        let diff = form.string(from: start, to: end)
        return diff
    }
}
