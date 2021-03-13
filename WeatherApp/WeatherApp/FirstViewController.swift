//
//  FirstViewController.swift
//  WeatherApp
//
//  Created by Tim Nanney on 3/11/21.
//

import Foundation
import UIKit
import Alamofire

class CurrentTemp: UIViewController {
    
    var incomingTemp = Double()
    var incomingMin = Double()
    var incomingMax = Double()
    var incomingTempLbl = UILabel()
    var incomingMinLbl = UILabel()
    var incomingMaxLbl = UILabel()
    let currentLbl = UILabel()
    let minLbl = UILabel()
    let maxLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCases(urlLink: "https://api.openweathermap.org/data/2.5/weather?lat=42.3314&lon=-83.0458&appid=00efb91840b0f39666cefd5bf7e3e400")
        
        view.backgroundColor = .lightGray
    }
    
    func addView() {
        incomingTempLbl.text = String(format: "%.f", incomingTemp)
        incomingTempLbl.font = .systemFont(ofSize: 64)
        incomingTempLbl.textColor = .black
        incomingMinLbl.text = String(format: "%.f", incomingMin)
        incomingMinLbl.font = .systemFont(ofSize: 24)
        incomingMinLbl.textColor = .black
        incomingMaxLbl.text = String(format: "%.f", incomingMax)
        incomingMaxLbl.font = .systemFont(ofSize: 24)
        incomingMaxLbl.textColor = .black
        minLbl.text = "Min"
        minLbl.textColor = .black
        maxLbl.text = "Max"
        maxLbl.textColor = .black
        currentLbl.text = "Current"
        currentLbl.textColor = .black
        
        let currentStack = UIStackView(arrangedSubviews: [currentLbl, incomingTempLbl])
        currentStack.axis = .vertical
        currentStack.alignment = .center
        let minStack = UIStackView(arrangedSubviews: [incomingMinLbl, minLbl])
        minStack.axis = .vertical
        minStack.alignment = .center
        let maxStack = UIStackView(arrangedSubviews: [incomingMaxLbl, maxLbl])
        maxStack.axis = .vertical
        maxStack.alignment = .center
        
        let otherTempsStack = UIStackView(arrangedSubviews: [minStack, maxStack])
        otherTempsStack.axis = .horizontal
        otherTempsStack.spacing = 32
        
        let mainTempStack = UIStackView(arrangedSubviews: [currentStack, otherTempsStack])
        mainTempStack.axis = .vertical
        mainTempStack.spacing = 32
        mainTempStack.alignment = .center
        let tempContainer = UIView()
        tempContainer.addSubview(mainTempStack)
        mainTempStack.translatesAutoresizingMaskIntoConstraints = false
        mainTempStack.centerXAnchor.constraint(equalTo: tempContainer.centerXAnchor).isActive = true
        mainTempStack.centerYAnchor.constraint(equalTo: tempContainer.centerYAnchor).isActive = true
        
        view.addSubview(tempContainer)
        tempContainer.translatesAutoresizingMaskIntoConstraints = false
        tempContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tempContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension CurrentTemp {
    //api call for all regions in the United States
    func fetchCases(urlLink: String) {
                
        let request = AF.request(urlLink)
        
        request.responseDecodable(of: Current.self) { (response) in
            guard let casesTemp = response.value else { return }
            print("test1", response.value ?? 0)
            self.incomingTemp = (casesTemp.main.currentTemp - 273.15) * 9/5 + 32
            self.incomingMin = (casesTemp.main.maxTemp - 273.15) * 9/5 + 32
            self.incomingMax = (casesTemp.main.minTemp - 273.15) * 9/5 + 32
            
            self.addView()
        }
    }
}
