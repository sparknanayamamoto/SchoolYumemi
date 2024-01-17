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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        yumemiTenki.delegate = self
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.viewWillEnterForeground(_:)),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
        
        self.updateWeather()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        yumemiTenki.setYumemiWeather()
    }
    
}


extension ViewController:YumemiDelegate {
    func setMinTemperature(min: Int) {
        self.minTemperatureLabel.text = String(min)
    }
    
    func setMaxTemperature(max: Int) {
        self.maxTemperatureLabel.text = String(max)
    }
    
    
    func setErrorWeather(alertMessage: String) {
        let dialog = UIAlertController(title: "確認", message: alertMessage, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(dialog, animated: true, completion: nil)
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
        
        weatherIcon.image = UIImage(named: imageName)
        weatherIcon.tintColor = tintColor
    }
    
}

