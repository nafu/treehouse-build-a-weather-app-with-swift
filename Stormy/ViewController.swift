//
//  ViewController.swift
//  Stormy
//
//  Created by Fumiya Nakamura on 2014-11-21.
//  Copyright (c) 2014 Fumiya Nakamura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var iconView: UIImageView!
	@IBOutlet weak var currentTimeLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var humidityLabel: UILabel!
	@IBOutlet weak var precipitationLabel: UILabel!
	@IBOutlet weak var summaryLabel: UILabel!

	private let apiKey = "YOUR_API_KEY"

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
		let forecastURL = NSURL(string: "35.658380,139.701595", relativeToURL: baseURL)
		let weatherData = NSData(contentsOfURL: forecastURL!, options: nil, error: nil)
		let sharedSession = NSURLSession.sharedSession()
		let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithRequest(NSURLRequest(URL: forecastURL!), completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
			if (error != nil) {
				return println(error)
			}

			let dataObject = NSData(contentsOfURL: location)
			let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary
			let currentWeather = Current(weatherDictionary: weatherDictionary)

			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.temperatureLabel.text = "\(currentWeather.temperature)"
				self.iconView.image = currentWeather.icon!
				self.currentTimeLabel.text = "At \(currentWeather.currentTime!) it is"
				self.humidityLabel.text = "\(currentWeather.humidity)"
				self.precipitationLabel.text = "\(currentWeather.precipProbability)"
				self.summaryLabel.text = "\(currentWeather.summary)"
			})

			println(currentWeather.currentTime!)
		})
		downloadTask.resume()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}
