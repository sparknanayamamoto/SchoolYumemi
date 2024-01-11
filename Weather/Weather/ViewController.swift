//
//  ViewController.swift
//  Weather
//
//  Created by spark-04 on 2024/01/11.
//

import UIKit
import YumemiWeather


class ViewController: UIViewController {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func whetherChange(_ sender: Any) {
        responseWeatherType()
    }
    
    func responseWeatherType() {
        let weatherStrings = YumemiWeather.fetchWeatherCondition()
        switch weatherStrings {
        case "sunny":
            self.weatherIcon.image = UIImage(named: "sunny")
            self.weatherIcon.tintColor = .red
        case "cloudy":
            self.weatherIcon.image = UIImage(named: "cloudy")
            self.weatherIcon.tintColor = .gray
        case "rainy":
            self.weatherIcon.image = UIImage(named: "rainy")
            self.weatherIcon.tintColor = .blue
        default: break
        }
    }
    
}

