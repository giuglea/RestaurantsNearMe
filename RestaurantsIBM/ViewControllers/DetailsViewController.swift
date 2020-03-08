//
//  DetailsViewController.swift
//  RestaurantsIBM
//
//  Created by Anamaria Mutu on 3/2/20.
//  Copyright © 2020 DragosRotaru. All rights reserved.
//

import UIKit
import MapKit


class DetailsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet var arrImageViews: [UIImageView]!
    
    
    var restaurant: RestaurantModel!
    
    private var imagesDictionary: [String: UIImage?] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = restaurant.name
        descriptionLabel.text = restaurant.description

        configureMap()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        //handleTouchLocation(withTouches: )
    }
    
    private func configureMap() {
        
        let location = CLLocationCoordinate2D(latitude: Double(restaurant.latitude) ?? 44.4268, longitude: Double(restaurant.longitude) ?? 26.1025)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)

        mapView.setRegion(region, animated: true)


        let annotation = MKPointAnnotation()
        annotation.title = restaurant.name
        annotation.coordinate = location

        mapView.addAnnotation(annotation)

        mapView.delegate = self
    }
    
    private func downloadImage(at indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        let imagePath = restaurant.imagePaths[indexPath.item]
        
        guard let imageURL = URL(string: imagePath) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: imageURL) {(data, response, error) in
            guard let data = data,
                let image = UIImage(data: data),
                error == nil else {
                    completion(nil)
                    return
            }
            completion(image)
        }
        task.resume()
    }
}

extension DetailsViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.isEnabled = true
        annotationView.canShowCallout = true

        return annotationView
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurant.imagePaths.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let image = imagesDictionary[self.restaurant.imagePaths[indexPath.item]] {
            cell.imageCell.image = image
        } else {
            downloadImage(at: indexPath) { [weak self] (image) in
                DispatchQueue.main.async {
                    guard let restaurantImage = image,
                        let id = self?.restaurant.imagePaths[indexPath.item] else {
                            return
                    }
                    self?.imagesDictionary[id] = restaurantImage
                    cell.imageCell.image = restaurantImage
                }
            }
        }

        return cell
    }


}

extension DetailsViewController{
    
    func setUpStarStack() {
        starStackView.tag = 5007
        arrImageViews.first?.tag = 5009
    }
    func handleTouchLocation(withTouches touches: Set<UITouch>) {
        let touchLocaction = touches.first
        let location = touchLocaction?.location(in: starStackView)
        if(touchLocaction?.view?.tag == 5007) {
//            var intRating: Int = 0
            arrImageViews.forEach { (imageView) in
                if  ((location?.x)! > imageView.frame.origin.x) {
                    let i = arrImageViews?.firstIndex(of: imageView)
//                    intRating = i! + 1;
                    
                    imageView.image = UIImage(systemName: "star.fill")
                } else {
                    if(imageView.tag != 5009) {
                        imageView.image = UIImage(systemName: "starr")
                    }
                }
            }
        }
    }
    
}
