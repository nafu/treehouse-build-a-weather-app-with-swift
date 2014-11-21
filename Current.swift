//
//  Current.swift
//  Stormy
//
//  Created by Fumiya Nakamura on 2014-11-21.
//  Copyright (c) 2014 Fumiya Nakamura. All rights reserved.
//

import Foundation

struct Current {
	var currentTime: Int
	var temperature: Int
	var humidity: Double
	var precipProbability: Double
	var summary: String
	var icon: String

	init(weatherDictionary: NSDictionary) {
		let currentWeather: NSDictionary = weatherDictionary["currently"] as NSDictionary
		currentTime = currentWeather["time"] as Int
	}
}