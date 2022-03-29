//
//  CitiesViewController.swift
//  NetworkingHW
//
//  Created by Tolgay Dulger on 18.11.2021.
//

import UIKit

class CitiesViewController: UITableViewController {

    let dataSource = DataSource()
    
    @IBOutlet var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cities"
        dataSource.loadCityList()
        dataSource.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.getNumberOfCities()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        let city = dataSource.getCityWithIndex(index: indexPath.row)
        cell.cityNameLabel.text = city.Name
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! CityCell
        if let indexPath = self.cityTableView.indexPath(for: cell) {
            let city = dataSource.getCityWithIndex(index: indexPath.row)
            let regionViewController = segue.destination as! RegionsViewController
            regionViewController.selectedCityId = city.Id
        }
    }
}

extension CitiesViewController: DataSourceDelegate {
    func regionListLoaded() {}
    func pharmacyListLoaded() {}
    func pharmacyDetailLoaded(pharmacyDetail: PharmacyDetail) {}
    func cityListLoaded() {
        cityTableView.reloadData()
    }
}
