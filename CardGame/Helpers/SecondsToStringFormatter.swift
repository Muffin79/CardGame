//
//  SecondsToStringFormatter.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 09.03.2025.
//

import Foundation

struct SecondsToStringFormatter {
    private let formatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour]
        formatter.zeroFormattingBehavior = .pad
        
        return formatter
    }()
    
    func secondsToString(_ seconds: Int) -> String {
        let output = formatter.string(from: TimeInterval(seconds))!
        return seconds < 3600 ? String(output[output.range(of: ":")!.upperBound...]) : output
    }
}
