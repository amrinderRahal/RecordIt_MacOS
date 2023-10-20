//
//  Double+Extension.swift
//  RecordIt
//
//  Created by Amrinder on 20/10/23.
//

import Foundation

extension Double {
    func asString(style: DateComponentsFormatter.UnitsStyle = .abbreviated) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? "\(self)"
    }
    //    10000.asString(style: .positional)  // 2:46:40
    //    10000.asString(style: .abbreviated) // 2h 46m 40s
    //    10000.asString(style: .short)       // 2 hr, 46 min, 40 sec
    //    10000.asString(style: .full)        // 2 hours, 46 minutes, 40 seconds
    //    10000.asString(style: .spellOut)    // two hours, forty-six minutes, forty seconds
    //    10000.asString(style: .brief)       // 2hr 46min 40sec
}
