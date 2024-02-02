//
//  ViewController.swift
//  NefubUIKit
//
//  Created by Jasper Mutsaerts on 03/11/2022.
//

import NefubApi
import UIKit

class ViewController: UITableViewController {
    private var locations: [Location] = []
    private var api = NefubApi()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        view.addSubview(spinner)
    
    
        let noResultsLabel = UILabel()
        noResultsLabel.text = "No locations found"
        view.addSubview(noResultsLabel)
        noResultsLabel.isHidden = true
    
        spinner.translatesAutoresizingMaskIntoConstraints = false
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),

            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
       ])
        
        
        api.playingDays(seasonId: 2022) { playingDays in
            var locations: [Location] = []
            playingDays
                .flatMap { $0.locations }
                .forEach { location in
                    if !locations.contains(location) {
                        locations.append(location)
                    }
                }
            self.locations = locations.sorted {
                $0.name! < $1.name!
            }
            spinner.stopAnimating()
            noResultsLabel.isHidden = !self.locations.isEmpty
            self.tableView.reloadData()
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = locations[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuse")

        cell.textLabel?.text = location.name ?? ""
        cell.detailTextLabel?.text = location.id.description

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]

        let vc = LocationViewController()
        vc.location = location
        navigationController?.pushViewController(vc, animated: true)
    }
}

