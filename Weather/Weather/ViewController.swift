//
//  ViewController.swift
//  Weather
//
//  Created by spark-04 on 2024/01/11.
//

import UIKit


class ViewController: UIViewController {
    
    let yumemiTenkiDetail = YumemiTenkiDetail()
    
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
    }
    
    @objc func viewWillEnterForeground(_ notification: Notification) {
        reloadWeather()
    }
    
    func reloadWeather(){
        startActivityIndicator.startAnimating()
        yumemiTenkiDetail.setYumemiWeatherInfo { result in
            
            self.startActivityIndicator.stopAnimating()
            
            switch result {
            case .success(let (weather, max, min)):
                self.completionWeather(weather: weather, max: max, min: min)
            case .failure(let error):
                self.completionWeaterError(alertMessage: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func whetherChange(_ sender: Any) {
        reloadWeather()
    }
    
    func completionWeaterError(alertMessage: String) {
        DispatchQueue.main.async {
            let dialog = UIAlertController(title: "確認", message: alertMessage, preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
    }
    
    func completionWeather(weather: String, max: Int, min: Int) {
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
        minTemperatureLabel.text = String(max)
        maxTemperatureLabel.text = String(max)
    }
    
}





