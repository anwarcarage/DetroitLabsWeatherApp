//
//  SecondViewController.swift
//  WeatherApp
//
//  Created by Tim Nanney on 3/11/21.
//

import Foundation
import UIKit
import Alamofire

class FiveDayTemp: UIViewController {
    
    var incomingData: [ListDisplayable] = []
    
    let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchForecast(urlLink: "https://api.openweathermap.org/data/2.5/forecast?lat=42.3314&lon=-83.0458&appid=00efb91840b0f39666cefd5bf7e3e400")
        
        view.backgroundColor = .lightGray
        
        let width = UIScreen.main.bounds.width - 16
        let height = CGFloat(150)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: width, height: height)
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumInteritemSpacing = 8
            flowLayout.minimumLineSpacing = 8

        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self

        //don't forget this!!!
        collectionView.register(TempCell.self, forCellWithReuseIdentifier: "tempCell")

        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension FiveDayTemp: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tempData = incomingData.chunked(into: 8)
        return tempData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tempData = incomingData.chunked(into: 8)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tempCell", for: indexPath) as? TempCell

       
        
            cell?.update(
                cellData: tempData[indexPath.item]
            )
        
        return cell ?? UICollectionViewCell()
    }
}

extension FiveDayTemp {
    func fetchForecast(urlLink: String) {
        
        let request = AF.request(urlLink)
        
        request.responseDecodable(of: FiveDay.self) { (response) in
            guard let forecast = response.value else { return }
            //print("test2", response.value ?? 0)
            self.incomingData = forecast.list
            self.collectionView.reloadData()
        }
    }
}

class TempCell: UICollectionViewCell {
    
    var cellData: [ListDisplayable] = []
    var cellTimeStamp = UILabel()
    var cellTempLbl = UILabel()
    var cellIcon = String()
    var cellImage = UIImageView()
    
    let width = UIScreen.main.bounds.width - 16
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.cellImage.image = image
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tempStack = UIStackView(arrangedSubviews: [cellTimeStamp, cellTempLbl, cellImage])
        tempStack.axis = .vertical
        tempStack.alignment = .center
        
        let cellContainer = UIView()
        cellContainer.addSubview(tempStack)
        tempStack.translatesAutoresizingMaskIntoConstraints = false
        tempStack.topAnchor.constraint(equalTo: cellContainer.safeAreaLayoutGuide.topAnchor).isActive = true
        tempStack.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor).isActive = true
        tempStack.bottomAnchor.constraint(equalTo: cellContainer.bottomAnchor).isActive = true
        tempStack.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor).isActive = true
        
        contentView.addSubview(cellContainer)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 1
        
        cellContainer.translatesAutoresizingMaskIntoConstraints = false
        cellContainer.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        cellContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        cellContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(cellData: [ListDisplayable]) {
        cellTempLbl.text = String(format: "%.f", cellData[0].mainClass.temp)
        cellTimeStamp.text = cellData[0].timeStamp
        setImage(from: "https://openweathermap.org/img/wn/\(cellData[0].foreWeather[0].icon)@2x.png")
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

