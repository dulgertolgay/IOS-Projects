//
//  DataSourceDelegate.swift
//  NetworkingHW
//
//  Created by Tolgay Dulger on 18.11.2021.
//

import Foundation

protocol DataSourceDelegate {
    func cityListLoaded()
    func regionListLoaded()
    func pharmacyListLoaded()
    func pharmacyDetailLoaded(pharmacyDetail: PharmacyDetail)
}
