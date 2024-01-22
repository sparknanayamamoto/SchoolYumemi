//
//  ViewController.swift
//  Weather
//
//  Created by spark-04 on 2024/01/11.
//

import UIKit


class ViewController: UIViewController {
    
    let yumemiTenki = YumemiTenki()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var startActivityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        yumemiTenki.delegate = self
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.viewWillEnterForeground(_:)),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
        
        startActivityIndicator.hidesWhenStopped = true
    }
    
    
    
    @objc func viewWillEnterForeground(_ notification: Notification) {
        self.updateWeather()
    }
    
    
    func updateWeather () {
        yumemiTenki.setYumemiWeather()
    }
    
    
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func whetherChange(_ sender: Any) {
        self.startActivityIndicator.startAnimating()
        yumemiTenki.setYumemiWeather()
    }
}



extension ViewController:YumemiDelegate {
    
    func setMinTemperature(min: Int) {
        DispatchQueue.main.async {
            self.minTemperatureLabel.text = String(min)
        }
    }
    
    func setMaxTemperature(max: Int) {
        DispatchQueue.main.async {
            self.maxTemperatureLabel.text = String(max)
        }
    }
    
    func setErrorWeather(alertMessage: String) {
        DispatchQueue.main.async {
            let dialog = UIAlertController(title: "確認", message: alertMessage, preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
            self.startActivityIndicator.stopAnimating()
        }
    }
    
    func setWeatherImage(type: String) {
            var imageName = "sunny"
            var tintColor = UIColor.red
            
            switch type {
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
            
        DispatchQueue.main.async { [self] in
            weatherIcon.image = UIImage(named: imageName)
            weatherIcon.tintColor = tintColor
            startActivityIndicator.stopAnimating()
        }
    }
    
}


