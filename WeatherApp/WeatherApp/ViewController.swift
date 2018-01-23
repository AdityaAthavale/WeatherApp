//
//  ViewController.swift
//  WeatherApp
//
//  Created by Aditya Athavale on 1/22/18.
//  Copyright © 2018 Aditya Athavale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtCity : UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let weather = segue.destination as? WeatherViewController {
            weather.city = txtCity?.text
        }
    }
    
    @IBAction func fetchWeather(sender : Any) {
        
        if txtCity?.text?.count == 0 {
            let alert = UIAlertController(title: "Error", message: "Please enter city in United States", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                (action) in
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        self.performSegue(withIdentifier: "ShowWeather", sender: self)
    }
    
    @IBAction func exitToThisView(segue : UIStoryboardSegue) {
    }


}

