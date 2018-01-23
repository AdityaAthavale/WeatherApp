//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Aditya Athavale on 1/22/18.
//  Copyright © 2018 Aditya Athavale. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, NetWorkLayerDelegate {

    var weather : WeatherData?
    var city : String?
    
    @IBOutlet weak var lblStatus : UILabel?
    @IBOutlet weak var lblTemperature : UILabel?
    @IBOutlet weak var lblPressure : UILabel?
    @IBOutlet weak var lblHumidity : UILabel?
    @IBOutlet weak var iconStatus : UIImageView?
    let networklayer: NetworkLayer = NetworkLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networklayer.delegate = self
        if let city = self.city?.addingPercentEncoding(withAllowedCharacters: CharacterSet()) {
            networklayer.getWeatherData(for: city)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didFinishWithSuccess(_ data: AnyObject?) {
        if let weather = data as? WeatherData {
            self.weather = weather
            if self.weather?.weather != nil {
                networklayer.getIconWith(imageName: (self.weather?.weather?.last?.icon)!)
                DispatchQueue.main.async {
                    self.lblStatus?.text = weather.weather?.last?.desc
                    if let temp = weather.main?.currentTemp {
                        let farenhit = 1.8 * (temp - 273) + 32
                        self.lblTemperature?.text = "\(farenhit) ºF"
                    }
                    else {
                        self.lblTemperature?.text = "N/A"
                    }
                    if let pressure = weather.main?.pressure {
                        self.lblPressure?.text = "\(pressure)mb"
                    } else {
                        self.lblPressure?.text = "N/A"
                    }

                    if let humidity = weather.main?.humidity {
                        self.lblHumidity?.text = "\(humidity)%"
                    } else {
                        self.lblHumidity?.text = "N/A"
                    }

                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Something went wrong in fetching weather data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        if let image = data as? UIImage {
            DispatchQueue.main.async {
                self.iconStatus?.image = image
            }
        }
    }
    
    func didFailWith(_ response: URLResponse?, error: Error?) {
        let alert = UIAlertController(title: "Error", message: "Something went wrong in fetching weather data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (action) in
        }))
        self.present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
