//
//  TextClassifier.swift
//  NewsApp
//
//  Created by alex on 5/7/23.
//

import Foundation
import CoreML

func predictSentement(text: String) -> String? {
    do {
        let config = MLModelConfiguration()
        let sentimentClassifier = try MyTextClassifier(configuration: config)
        let prediction = try sentimentClassifier.prediction(text: text)
        return prediction.label
    } catch {
        print("Failed to make prediction: \(error.localizedDescription)")
        return nil
    }
}
