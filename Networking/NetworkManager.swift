//
//  NetworkManager.swift
//  RestaurantsIBM
//
//  Created by Vlad Țîrloiu on 04/03/2020.
//  Copyright © 2020 DragosRotaru. All rights reserved.
//

import Foundation

class NetworkManager {
    private var urlSession = URLSession(configuration: .default)
    
    let urlString = "https://d181c8f5-1bec-4249-b8a9-d0c517513da8.mock.pstmn.io/restaurants"
    
    func getRestaurants(completionHandler: @escaping ([RestaurantModel]?, String?) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, "Not a valid URL")
            return
        }
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, "Erorr! No data returned!")
                return
            }
            do {
                let decoder = JSONDecoder()
                let restaurants = try decoder.decode([RestaurantModel].self, from: data)
                completionHandler(restaurants, nil)
            } catch {
                completionHandler(nil, "Error! Decode not successful")
            }
        }
        dataTask.resume()
    }
    
    
    func getRestaurantsAlternative(completionHandler: @escaping ([RestaurantModel]?,String) -> Void) {
       // guard let url = 
    }
}
