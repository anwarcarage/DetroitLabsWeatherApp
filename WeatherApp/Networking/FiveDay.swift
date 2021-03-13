//
//  FiveDay.swift
//  WeatherApp
//
//  Created by Tim Nanney on 3/11/21.
//

import Foundation
import Alamofire

//MARK: - Welcome
struct FiveDay: Decodable {
    var list: [List]
}

//MARK: - List
struct List: Decodable {
    var main: MainClass
    var weather: [Weather]
    var dtTxt: String

    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case dtTxt = "dt_txt"
    }
}

//MARK: - MainClass
struct MainClass: Decodable {
    var temp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
    }
}

//MARK: - Weather
struct Weather: Decodable {
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case icon
    }
}

extension List: ListDisplayable {
    var timeStamp: String {
        dtTxt
    }
    var mainClass: MainClass {
        main
    }
    var foreWeather: [Weather] {
        weather
    }
}
