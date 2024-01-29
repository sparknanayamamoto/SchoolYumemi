//
//  StartPageViewController.swift
//  Weather
//
//  Created by spark-04 on 2024/01/26.
//

import UIKit

let weatherDetailList = WeatherDetailList()
var areas: [AreaResponse] = []


class StartPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var weatherList: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    

    
    func fetchWeatherList(){
        Task {
            let weatherString = await weatherDetailList.setYumemiWeatherList()
            
            switch weatherString {
            case .success(let areas):
                self.areas = areas
                weatherList.reloadInputViews()
                
            case .failure(let error):
                self.complitionWeaterError(alertMessage: "Error: \(error.localizedDescription)")
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
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
