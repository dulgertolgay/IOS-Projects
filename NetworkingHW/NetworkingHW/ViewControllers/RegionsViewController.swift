//
//  RegionsViewController.swift
//  NetworkingHW
//
//  Created by Tolgay Dulger on 18.11.2021.
//

import UIKit

class RegionsViewController: UITableViewController {

    let dataSource = DataSource()
    var selectedCityId: Int?
    
    @IBOutlet var regionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Regions"
        dataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let cityId = selectedCityId {
            dataSource.loadRegionList(cityId: cityId)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.getNumberOfRegions()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell", for: indexPath) as! RegionCell
        let region = dataSource.getRegionWithIndex(index: indexPath.row)
        cell.regionNameLabel.text = region.Name
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! RegionCell
        if let indexPath = self.regionTableView.indexPath(for: cell) {
            let region = dataSource.getRegionWithIndex(index: indexPath.row)
            let pharmacyViewController = segue.destination as! PharmaciesViewController
            pharmacyViewController.selectedRegionId = region.Id
        }
    }
}

extension RegionsViewController: DataSourceDelegate {
    func cityListLoaded() {}
    func pharmacyListLoaded() {}
    func pharmacyDetailLoaded(pharmacyDetail: PharmacyDetail) {}
    func regionListLoaded() {
        regionTableView.reloadData()
    }
}
