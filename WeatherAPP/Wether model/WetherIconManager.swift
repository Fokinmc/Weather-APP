//
//  wetherIconManager.swift
//  WeatherAPP
//
//  Created by Mac on 18.09.2018.
//  Copyright © 2018 FokinMC. All rights reserved.
//

import Foundation
import UIKit

enum WetherIconManager: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    case UnpredictedIcon = "unpredicted-icon"
    
    init(rowValue: String) {
        switch rowValue {
        case "clear-day" : self = .ClearDay
        case "clear-night" : self = .ClearNight
        case "rain" : self = .Rain
        case "snow" : self = .Snow
        case "sleet" : self = .Sleet
        case "wind" : self = .Wind
        case "fog" : self = .Fog
        case "cloudy" : self = .Cloudy
        case "partly-cloudy-day" : self = .PartlyCloudyDay
        case "partly-cloudy-night" : self = .PartlyCloudyNight

        default: self = .UnpredictedIcon
        }
    }
}


extension WetherIconManager {
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}













