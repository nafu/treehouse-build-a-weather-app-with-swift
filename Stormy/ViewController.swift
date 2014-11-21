//
//  ViewController.swift
//  Stormy
//
//  Created by Fumiya Nakamura on 2014-11-21.
//  Copyright (c) 2014 Fumiya Nakamura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	private let apiKey = "YOUR_API_KEY"

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
		let forecastURL = NSURL(string: "35.658380,139.701595", relativeToURL: baseURL)
		let weatherData = NSData(contentsOfURL: forecastURL!, options: nil, error: nil)
		let sharedSession = NSURLSession.sharedSession()
		let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithRequest(NSURLRequest(URL: forecastURL!), completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
			println(response)
		})
		downloadTask.resume()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}
