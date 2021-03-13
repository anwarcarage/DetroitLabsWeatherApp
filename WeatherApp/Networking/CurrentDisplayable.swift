//
//  CurrentDisplayable.swift
//  WeatherApp
//
//  Created by Tim Nanney on 3/11/21.
//

import Foundation
import Alamofire

protocol CurrentDisplayable {
    var currentTemp : Double { get }
    var minTemp : Double { get }
    var maxTemp : Double { get }
}
