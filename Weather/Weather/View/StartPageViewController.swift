//
//  StartPageViewController.swift
//  Weather
//
//  Created by spark-04 on 2024/01/26.
//

import UIKit


class StartPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let weatherDetailList = WeatherDetailList()
    var areas: [AreaResponse] = []
    
    
    @IBOutlet weak var weatherList: UITableView!
    @IBOutlet weak var listIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        weatherList.refreshControl = refreshControl
        
        weatherList.delegate = self
        weatherList.dataSource = self
        
        listIndicator.hidesWhenStopped = true
        fetchWeatherList()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func refreshTableView() {
        weatherList.refreshControl?.endRefreshing()
        fetchWeatherList()
    }
    
    func fetchWeatherList(){
        Task {
            listIndicator.startAnimating()
            let weatherString = await weatherDetailList.setYumemiWeatherList()
            listIndicator.stopAnimating()
            switch weatherString {
            case .success(let areas):
                self.areas = areas
                weatherList.reloadData()
            case .failure(let error):
                self.showError(alertMessage: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let weatherList = areas[indexPath.row]
        cell.textLabel?.text  = weatherList.area.rawValue
        let maxTemperature = weatherList.info.max_temperature
        let minTemperature = weatherList.info.min_temperature
        cell.detailTextLabel?.text = "最高気温は\(maxTemperature)℃です。最低気温は\(minTemperature)℃です。"
        
        switch weatherList.info.weather_condition {
        case "sunny":
            cell.imageView?.image = UIImage(named: "sunny")
            cell.imageView?.tintColor = UIColor.red
        case "cloudy":
            cell.imageView?.image = UIImage(named: "cloudy")
            cell.imageView?.tintColor = UIColor.gray
        case "rainy":
            cell.imageView?.image = UIImage(named: "rainy")
            cell.imageView?.tintColor = UIColor.blue
        default:
            break
        }
        
        return cell
    }
    
    func showError(alertMessage: String) {
        let dialog = UIAlertController(title: "確認", message: alertMessage, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "リトライ", style: .default, handler: { action in
            self.fetchWeatherList()
        }))
        self.present(dialog, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail",
           let indexPath = weatherList.indexPathForSelectedRow,
           let destination = segue.destination as? ViewController {
            destination.areaInfo = areas[indexPath.row]
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
    
}
