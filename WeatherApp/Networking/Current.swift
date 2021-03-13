//
//  Current.swift
//  WeatherApp
//
//  Created by Tim Nanney on 3/11/21.
//

import Foundation
import Alamofire

//MARK: - Welcome
struct Current: Decodable {
    var main: Main
}

//MARK: - Main
struct Main: Decodable {
    var temp: Double
    var tempMin: Double
    var tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

extension Main: CurrentDisplayable {
    var currentTemp: Double {
        temp
    }
    
    var minTemp: Double {
        tempMin
    }
    var maxTemp: Double {
        tempMax
    }
}
