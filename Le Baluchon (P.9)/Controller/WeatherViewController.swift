//
//  MeteoViewController.swift
//  Le Baluchon
//
//  Created by Dusan Orescanin on 28/03/2022.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherDescriptionNYC: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureNYC: UILabel!
    @IBOutlet weak var weatherDescriptionSTRG: UILabel!
    @IBOutlet weak var temperatureSTRG: UILabel!
    @IBOutlet weak var feelTemp: UILabel!
    @IBOutlet weak var tempMini: UILabel!
    @IBOutlet weak var tempMaxi: UILabel!
    @IBOutlet weak var tempMinSTRG: UILabel!
    @IBOutlet weak var tempMaxSTRG: UILabel!
    
    let newYorkWeatherURL =  "https://api.openweathermap.org/data/2.5/weather?id=5128581&appid=ed35a55acedfd49017de43870d7d31cd&units=metric&lang=fr"
    
    let STRGWeatherURL = "https://api.openweathermap.org/data/2.5/weather?q=strasbourg&appid=ed35a55acedfd49017de43870d7d31cd&units=metric&lang=fr"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        date()
        makeAPICall()
    }
}

// MARK: - MANAGE API CALLS

extension WeatherViewController {
    
    // NYC weather
    private func makeAPICall() {
        WeatherServices.shared.getWeather(urlString: newYorkWeatherURL) { (result) in
            switch result {
            case .some(let response):
                self.updateWeatherDisplayNYC(response: response)
            case .none :
                self.presentAlert()
            }
        }
        // France weather
        WeatherServices.shared.getWeather(urlString: STRGWeatherURL) { (result) in
            switch result {
            case .some(let response):
                self.updateWeatherDisplaySTRG(response: response)
            case .none:
                self.presentAlert()
            }
        }
    }
    // Update Weather Display NYC
    private func updateWeatherDisplayNYC(response: WeatherResponse) {
        self.weatherDescriptionNYC.text = response.weather[0].description.capitalizingFirstLetter()
        self.temperatureNYC.text = "\(Int(response.main.temperature.rounded()))??C"
        self.feelTemp.text = "\(Int(response.main.feelsLike.rounded()))??"
        self.tempMini.text = "\(Int(response.main.tempMin.rounded()))??"
        self.tempMaxi.text = "\(Int(response.main.tempMax.rounded()))??"
        
        if let data = try? Data(contentsOf: response.weather[0].weatherIconURL){
            self.weatherIcon.image = UIImage(data: data)
        }
    }
    // Update Weather Display France
    private func updateWeatherDisplaySTRG(response: WeatherResponse) {
        self.weatherDescriptionSTRG.text = response.weather[0].description.capitalizingFirstLetter()
        self.temperatureSTRG.text = "\(Int(response.main.temperature.rounded()))??C"
        self.tempMinSTRG.text = "Min.\(Int(response.main.tempMin.rounded()))??"
        self.tempMaxSTRG.text = "Max.\(Int(response.main.tempMax.rounded()))??"
    }
}

// MARK: - PRESENT ALERTS

extension WeatherViewController {
    
    private func presentAlert() {
        let alertVC = UIAlertController.init(title: "Une erreur est survenue", message: "erreur de chargement", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - MANAGE DATE

extension WeatherViewController {
    private func date() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateStyle = .full
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "EEEE d MMMM yyyy"
        dateLabel.text = dateFormatter.string(from: date).capitalizingFirstLetter()
    }
}

