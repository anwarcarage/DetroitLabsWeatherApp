//
//  ViewController.swift
//  WeatherApp
//
//  Created by Tim Nanney on 3/11/21.
//

//api call api.openweathermap.org/data/2.5/weather?lat=83.0458&lon=42.3314&appid=00efb91840b0f39666cefd5bf7e3e400
//api call api.openweathermap.org/data/2.5/forecast?lat=83.0458&lon=42.3314&appid=00efb91840b0f39666cefd5bf7e3e400

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create instance of view controllers
        let firstVC = CurrentTemp()
        let secondVC = FiveDayTemp()
        
        //set title
        firstVC.title = "Current"
        secondVC.title = "5 Day"
        
        //assign view controllers to tab bar
        self.setViewControllers([firstVC, secondVC], animated: false)
        self.tabBar.tintColor = .black
        
        guard let items = self.tabBar.items else { return }
        let images = ["house", "bell"]
        for x in 0...1 {
            items[x].image = UIImage(systemName: images[x])
        }
    }
}

