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
        
        if let flowLayout = weatherCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
        }
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSizeWidth: CGFloat = self.view.frame.width / 2
        let cellSizeHeight: CGFloat = self.view.frame.height / 2
        return CGSize(width: cellSizeWidth, height: cellSizeHeight / 2)
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


