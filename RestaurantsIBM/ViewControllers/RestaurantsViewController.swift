//
//  ViewController.swift
//  RestaurantsIBM
//
//  Created by DragosRotaru on 28/02/2020.
//  Copyright © 2020 DragosRotaru. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //let urlString = “https://d181c8f5-1bec-4249-b8a9-d0c517513da8.mock.pstmn.io”
    private var restaurantArray: [RestaurantModel]?
    private var restaurantArrayFiltered: [RestaurantModel]?
    private var networkManager: NetworkManager?
    private var imagesDictionary: [String: UIImage?]?
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        networkManager = NetworkManager()
        retrieveData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails",
            let detailVC = segue.destination as? DetailsViewController,
            let restaurant = sender as? RestaurantModel {
            detailVC.restaurant = restaurant
        }
    }
    
    func retrieveData() {
        networkManager?.getRestaurants(completionHandler: { [weak self] (restaurants, errorMessage) in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                guard errorMessage == nil else {
                    self.handleError(message: errorMessage)
                    return
                }
                guard let restaurants = restaurants else {
                    self.handleError(message: "No restaurants found")
                    return
                }
                self.restaurantArray = restaurants
                self.restaurantArrayFiltered = restaurants
                self.tableView.reloadData()
            }
        })
    }
    
    func downloadImage(restaurant: RestaurantModel, complitionHandler: @escaping (UIImage?) -> Void) {
        guard let imagePath = restaurant.imagePaths.first,
            let imageURL = URL(string: imagePath) else {
                complitionHandler(nil)
                return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            guard error == nil,
                let data = data,
                let image = UIImage(data: data) else {
                    complitionHandler(nil)
                    return
            }
            complitionHandler(image)
        }
        task.resume()
    }
    
    func handleError(message: String?) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action) in
            self.retrieveData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension RestaurantsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        restaurantArrayFiltered?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let restaurantCell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell") as? RestaurantTableViewCell,
            let model = restaurantArrayFiltered?[indexPath.row] else {
                return UITableViewCell()
                
        }
        restaurantCell.nameLabel.text = model.name
        restaurantCell.descriptionLabel.text = model.description
        restaurantCell.setRatingStars(rating: model.rating)
        
        if let image = imagesDictionary?[model.id] {
            restaurantCell.restaurantImageView.image = image
        } else {
            downloadImage(restaurant: model) { [weak self] (image) in
                DispatchQueue.main.async {
                    guard let image = image else {
                        restaurantCell.restaurantImageView.image = UIImage(named: "osho")
                        return
                    }
                    self?.imagesDictionary?[model.id] = image
                    restaurantCell.restaurantImageView.image = image
                }
            }            
        }
        return restaurantCell
    }
    
    
}

extension RestaurantsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = restaurantArrayFiltered?[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: restaurant)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension RestaurantsViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        restaurantArrayFiltered = restaurantArray

          if searchText.isEmpty == false {
            restaurantArrayFiltered = restaurantArray!.filter(
                {
                    for i in $0.tags{
                        if i.contains(searchText){return true}
                    }
                    return false
            })
                    //$0.tags.contains(searchText) })
          }

          tableView.reloadData()
    }
    
    
}
