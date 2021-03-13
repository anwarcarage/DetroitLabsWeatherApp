//
//  FiveDayDisplayable.swift
//  WeatherApp
//
//  Created by Tim Nanney on 3/11/21.
//

import Foundation
import Alamofire

protocol ListDisplayable {
    var timeStamp: String { get }
    var mainClass: MainClass { get }
    var foreWeather: [Weather] { get }
}
