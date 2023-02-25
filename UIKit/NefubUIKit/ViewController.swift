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

