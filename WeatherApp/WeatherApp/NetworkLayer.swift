//
//  NetworkLayer.swift
//  WeatherApp
//
//  Created by Aditya Athavale on 1/22/18.
//  Copyright © 2018 Aditya Athavale. All rights reserved.
//

import UIKit

let API_KEY = "06f7de74ce2b75c61c97f6d042e623eb"
let BASE_URL = "https://api.openweathermap.org/data/2.5/weather?q=%@,us&APPID=" + API_KEY
let ICON_URL = "https://openweathermap.org/img/w/%@.png"
protocol NetWorkLayerDelegate {
    func didFinishWithSuccess(_ data : AnyObject?)
    func didFailWith(_ response : URLResponse?, error: Error?)
}

//Creating a singleton class to access all netowrk interactions.
//Making sure its extended from NSObject class.
class NetworkLayer: NSObject {

    var delegate : NetWorkLayerDelegate?
    
    private let session : URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    override init() {
        super.init()
    }
    
    func getWeatherData(for city: String) {
    
        let urlString = String(format: BASE_URL, city)
        if let url = URL(string: urlString) {
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let err = error {
                    self.delegate?.didFailWith(response, error: err)
                    return
                }
                else if data == nil {
                    let err = NSError(domain: "ServerDomain", code: 1234, userInfo: ["Message": "No data received from the service"])
                    self.delegate?.didFailWith(nil, error: (err as Error))
                    return
                }
                self.delegate?.didFinishWithSuccess(WeatherModel.parseWeatherModelData(data!) as AnyObject)
            }).resume()
        }
        else {
            let err = NSError(domain: "ProgrammerDomain", code: 1234, userInfo: ["Message": "Could not form URL from sent string."])
            self.delegate?.didFailWith(nil, error: (err as Error))
            return
        }
    }
    
    func getIconWith(imageName : String) {
        let urlString = String(format: ICON_URL, imageName)
        
        if let url = URL(string: urlString) {
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let err = error {
                    self.delegate?.didFailWith(response, error: err)
                    return
                }
                else if data == nil {
                    let err = NSError(domain: "ServerDomain", code: 1234, userInfo: ["Message": "No data received from the service"])
                    self.delegate?.didFailWith(nil, error: (err as Error))
                    return
                }
                self.delegate?.didFinishWithSuccess(UIImage(data: data!, scale: 2.0) as AnyObject)
            }).resume()
        }
        else {
            let err = NSError(domain: "ProgrammerDomain", code: 1234, userInfo: ["Message": "Could not form URL from sent string."])
            self.delegate?.didFailWith(nil, error: (err as Error))
            return
        }
    }
}
