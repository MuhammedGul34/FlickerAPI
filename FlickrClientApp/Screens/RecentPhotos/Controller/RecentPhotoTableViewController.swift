//
//  RecentPhotoTableViewController.swift
//  FlickrClientApp
//
//  Created by Muhammed Gül on 13.12.2022.
//

import UIKit

class RecentPhotoTableViewController: UITableViewController, UISearchResultsUpdating {
    
    private var response : PhotosResponse? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        setupSearchController()
        fetchRecentPhotos()
    }
    
    private func setupSearchController(){
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type Something to search"
        navigationItem.searchController = search
    }
    
    private func fetchRecentPhotos(){
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=de0b083d4a218ed778abc1dbdc6811e2&format=json&nojsoncallback=1&extras=description,owner_name,icon_server,url_n,url_z") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint(error)
                return
            }
            if let data = data,  let response = try?JSONDecoder().decode(PhotosResponse.self, from: data) {
                self.response = response
            }
        }.resume()
    }
    
    private func searchPhotos(with text: String){
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=de0b083d4a218ed778abc1dbdc6811e2&text=flower&format=json&nojsoncallback=1&extras=description,owner_name,icon_server,url_n,url_z") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint(error)
                return
            }
            if let data = data,  let response = try?JSONDecoder().decode(PhotosResponse.self, from: data) {
                self.response = response
            }
        }.resume()
    }
    
    private func fetchImage(with url: String?, completion : @escaping (Data) -> (Void)) {
        if let urlString = url, let url = URL(string: urlString){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    debugPrint(error)
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        completion(data)
                    }
                }
            }.resume()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.photos?.photo?.count ?? .zero
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoTableViewCell
        
        let photo = response?.photos?.photo?[indexPath.row]
        
        cell.ownerImageView.backgroundColor = .darkGray
        cell.ownerNameLabel.text = photo?.ownername
        
        fetchImage(with: photo?.urlN) { data in
            cell.photoImageView.image = UIImage(data: data)
        }
        
        cell.titleLabel.text = photo?.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSeque", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PhotoDetailViewController {
            // TODO: Send the phot that choosen to screen
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count > 2 {
            searchPhotos(with: text)
        }
    }
    
}
