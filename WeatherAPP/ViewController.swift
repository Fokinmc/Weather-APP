//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Mac on 18.09.2018.
//  Copyright © 2018 FokinMC. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humindityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activitiIndicator: UIActivityIndicatorView!
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        toggleActivitiIndicator(on: true)
        getCurrentWeatherData()
    }
    
    
    let locationManager = CLLocationManager()
    lazy var weatheManager = APIWeatherManager(apiKey: "d9e36ff94b5c26ddfc6f0240d619f458")
    
    var userLocation = CLLocation()
    var latitude: Double!
    var longitude: Double!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last! as CLLocation
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
        getCurrentWeatherData()
    }
    
    func getCurrentWeatherData() {
        let coordinates = Coordinates(latitude: latitude, longitude: longitude)
        weatheManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            self.toggleActivitiIndicator(on: false)
            switch result {
            case .Success(let currentWeather):
                self.updateUIWith(currentWeather: currentWeather)
            case .Failure(let error as NSError):
                let alertController = UIAlertController(title: "Unable to get data", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func updateUIWith(currentWeather: CurrentWeather) {
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.humindityLabel.text = currentWeather.humidityString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
    }
    
    
    func  toggleActivitiIndicator(on: Bool) {
        refreshButton.isHidden = on
        if on {
            activitiIndicator.startAnimating()
        } else {
            activitiIndicator.stopAnimating()
        }
    }
}

