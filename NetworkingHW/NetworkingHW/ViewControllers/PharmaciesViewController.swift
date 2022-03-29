//
//  PharmaciesViewController.swift
//  NetworkingHW
//
//  Created by Tolgay Dulger on 18.11.2021.
//

import UIKit

class PharmaciesViewController: UITableViewController {

    let dataSource = DataSource()
    var selectedRegionId: String?
    
    @IBOutlet var pharmacyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pharmacies"
        dataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let regionId = selectedRegionId {
            dataSource.loadPharmacyList(regionId: regionId)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.getNumberOfPharmacies()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PharmacyCell", for: indexPath) as! PharmacyCell
        let pharmacy = dataSource.getPharmacyWithIndex(index: indexPath.row)
        cell.pharmacyNameLabel.text = pharmacy.Name
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! PharmacyCell
        if let indexPath = self.pharmacyTableView.indexPath(for: cell) {
            let pharmacy = dataSource.getPharmacyWithIndex(index: indexPath.row)
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.selectedPharmacyId = pharmacy.Id
        }
    }
}

extension PharmaciesViewController: DataSourceDelegate {
    func cityListLoaded() {}
    func regionListLoaded() {}
    func pharmacyListLoaded() {
        pharmacyTableView.reloadData()
    }
    func pharmacyDetailLoaded(pharmacyDetail: PharmacyDetail) {}
    

}
