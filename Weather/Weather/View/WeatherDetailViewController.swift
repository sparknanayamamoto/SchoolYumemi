//
//  ViewController.swift
//  Weather
//
//  Created by spark-04 on 2024/01/11.
//

import UIKit


class ViewController: UIViewController {
    
    let yumemiTenkiDetail = YumemiTenkiDetail()
    var areaInfo: AreaResponse?
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var startActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startActivityIndicator.hidesWhenStopped = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.viewWillEnterForeground(_:)),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
        if let areaName = areaInfo?.area {
            navigationItem.title = areaName.rawValue
        }
        showData()
    }
    
    
    @objc func viewWillEnterForeground(_ notification: Notification) {
        reloadWeather()
    }
    
    
    func showData() {
        guard let area = self.areaInfo else { return }
        
        var weatherName = "sunny"
        var tintColor = UIColor.red
        switch area.info.weather_condition {
        case "sunny":
            weatherName = "sunny"
            tintColor = UIColor.red
        case "cloudy":
            weatherName = "cloudy"
            tintColor = UIColor.gray
        case "rainy":
            weatherName = "rainy"
            tintColor = UIColor.blue
        default:
            break
        }
        self.weatherIcon.image = UIImage(named: weatherName)
        self.weatherIcon.tintColor = tintColor
        self.maxTemperatureLabel.text = String(area.info.max_temperature)
        self.minTemperatureLabel.text = String(area.info.min_temperature)
    }
    
    
    func reloadWeather(){
        startActivityIndicator.startAnimating()
        Task {
            let weatherString = await yumemiTenkiDetail.setYumemiWeatherInfo()
            
            self.startActivityIndicator.stopAnimating()
            
            switch weatherString {
            case .success(let (weather, max, min)):
                self.complitionWeather(weather: weather, max: max, min: min)
            case .failure(let error):
                self.complitionWeaterError(alertMessage: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func whetherChange(_ sender: Any) {
        reloadWeather()
    }
    
    func complitionWeaterError(alertMessage: String) {
        let dialog = UIAlertController(title: "確認", message: alertMessage, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "リトライ", style: .default, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
    
    func complitionWeather(weather: String, max: Int, min: Int) {
        var imageName = "sunny"
        var tintColor = UIColor.red
        
        switch weather {
        case "sunny":
            imageName = "sunny"
            tintColor = UIColor.red
        case "cloudy":
            imageName = "cloudy"
            tintColor = UIColor.gray
        case "rainy":
            imageName = "rainy"
            tintColor = UIColor.blue
        default:
            break
        }
        weatherIcon.image = UIImage(named: imageName)
        weatherIcon.tintColor = tintColor
        minTemperatureLabel.text = String(min)
        maxTemperatureLabel.text = String(max)
    }
    
}







