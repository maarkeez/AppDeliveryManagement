//
//  DMPendingDelivery.swift
//  AppDeliveryManagement
//
//  Created by David Márquez Delgado on 18/3/18.
//  Copyright © 2018 David Márquez Delgado. All rights reserved.
//

import UIKit
import MapKit

class DMPendingDelivery: UIViewController {
    
    //MARK: - Variables locales
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var myTable: UITableView!
    
    //MARK: - IBActions
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
    }
    
    
}

//MARK: - Extensions
extension DMPendingDelivery : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
}
