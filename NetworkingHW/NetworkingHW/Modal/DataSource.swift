//
//  DataSource.swift
//  NetworkingHW
//
//  Created by Tolgay Dulger on 18.11.2021.
//

import Foundation

class DataSource {
    private var CityList: [City] = []
    private var RegionList: [Region] = []
    private var PharmacyList: [Pharmacy] = []
    private let baseURL = "https://koc.api.staging.tarentum.io"
    var delegate: DataSourceDelegate?
    
    init() {
    }
    
    func getNumberOfCities() -> Int {
            return CityList.count
        }
        
    func getCityWithIndex(index: Int) -> City {
            return CityList[index]
        }
    
    func getNumberOfRegions() -> Int {
            return RegionList.count
        }
        
    func getRegionWithIndex(index: Int) -> Region {
            return RegionList[index]
        }
    
    func getNumberOfPharmacies() -> Int {
            return PharmacyList.count
        }
        
    func getPharmacyWithIndex(index: Int) -> Pharmacy {
            return PharmacyList[index]
        }
    
    func loadCityList() {
        let urlSession = URLSession.shared
        if let url = URL(string: "\(baseURL)/city") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    let cityListData = try! decoder.decode([City].self, from: data)
                    self.CityList = cityListData
                    DispatchQueue.main.async {
                        self.delegate?.cityListLoaded()
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func loadRegionList(cityId: Int) {
        let urlSession = URLSession.shared
        if let url = URL(string: "\(baseURL)/city/\(cityId)/region") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    let regionListData = try! decoder.decode([Region].self, from: data)
                    self.RegionList = regionListData
                    DispatchQueue.main.async {
                        self.delegate?.regionListLoaded()
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func loadPharmacyList(regionId: String) {
        let urlSession = URLSession.shared
        if let url = URL(string: "\(baseURL)/region/\(regionId)/pharmacy") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    let pharmacyListData = try! decoder.decode([Pharmacy].self, from: data)
                    self.PharmacyList = pharmacyListData
                    DispatchQueue.main.async {
                        self.delegate?.pharmacyListLoaded()
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func loadPharmacyDetail(pharmacyId: String) {
        let urlSession = URLSession.shared
        if let url = URL(string: "\(baseURL)/pharmacy/\(pharmacyId)") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    let pharmacyData = try! decoder.decode(PharmacyDetail.self, from: data)
                    DispatchQueue.main.async {
                        self.delegate?.pharmacyDetailLoaded(pharmacyDetail: pharmacyData)
                    }
                }
            }
            dataTask.resume()
        }
    }
}
