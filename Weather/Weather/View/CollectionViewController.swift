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
        weatherCollectionView.delegate = self
        fetchWeatherIcon()
    }
    
    
    func fetchWeatherIcon(){
        Task {
            let weatherString = await weatherDetailList.setYumemiWeatherList()
            switch weatherString {
            case .success(let areas):
                self.areas = areas
                weatherCollectionView.reloadData()
            case .failure(let error):
                self.showError(alertMessage: "Error: \(error.localizedDescription)")
            }
        }
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
    
    func showError(alertMessage: String) {
        let dialog = UIAlertController(title: "確認", message: alertMessage, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "リトライ", style: .default, handler: { action in
            self.fetchWeatherIcon()
        }))
        self.present(dialog, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelect",
           let indexPath = weatherCollectionView.indexPathsForSelectedItems?.first,
           let destination = segue.destination as? ViewController {
            destination.areaInfo = areas[indexPath.row]
        }
    }
}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth: CGFloat = screenWidth / 4
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


