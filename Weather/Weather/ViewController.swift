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
    

    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 
    
    @IBAction func whetherChange(_ sender: Any) {
        responseWeatherType()
    }
    
    func responseWeatherType() {
        let weatherStrings = YumemiWeather.fetchWeatherCondition()
        
        var imageName = "sunny"
        var tintColor = UIColor.red
        
        switch weatherStrings {
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
