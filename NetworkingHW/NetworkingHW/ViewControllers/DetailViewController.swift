//
//  DetailViewController.swift
//  NetworkingHW
//
//  Created by Tolgay Dulger on 18.11.2021.
//

import UIKit

class DetailViewController: UIViewController {

    let dataSource = DataSource()
    var selectedPharmacyId: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pharmacy Detail"
        dataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let pharmacyId = selectedPharmacyId {
            dataSource.loadPharmacyDetail(pharmacyId: pharmacyId)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: DataSourceDelegate {
    func cityListLoaded() {}
    func pharmacyListLoaded() {}
    func pharmacyDetailLoaded(pharmacyDetail: PharmacyDetail) {
        print(pharmacyDetail)
        self.title = pharmacyDetail.Name
        self.nameLabel.text = "Name: \(pharmacyDetail.Name)"
        self.addressLabel.text = "Address: \(pharmacyDetail.Address)"
        self.phoneLabel.text = "Phone: \(pharmacyDetail.Phone)"
        
    }
    func regionListLoaded() {}
}
