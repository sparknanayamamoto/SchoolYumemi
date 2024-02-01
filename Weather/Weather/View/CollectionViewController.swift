//
//  CollectionViewController.swift
//  Weather
//
//  Created by spark-04 on 2024/01/31.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource {
    
    let weatherDetailList = WeatherDetailList()
    var areas: [AreaResponse] = []
    
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return areas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath)
        let weatherList = areas[indexPath.row]
        guard let imageCell = cell as? CollectionViewCell else {
            return cell
        }
        switch weatherList.info.weather_condition {
        case "sunny":
            imageCell.weatherImage.image = UIImage(named: "sunny")
            imageCell.weatherImage.tintColor = UIColor.red
        case "cloudy":
            imageCell.weatherImage.image = UIImage(named: "cloudy")
            imageCell.weatherImage.tintColor = UIColor.gray
        case "rainy":
            imageCell.weatherImage.image = UIImage(named: "rainy")
            imageCell.weatherImage.tintColor = UIColor.blue
        default:
            break
        }
        return imageCell
    }
}
    
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


