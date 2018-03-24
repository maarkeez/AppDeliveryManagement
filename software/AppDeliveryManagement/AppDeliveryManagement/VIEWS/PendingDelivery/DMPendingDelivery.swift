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
    var locationManager = CLLocationManager()
    //let authorizationStatus = CLLocationManager.authorizationStatus()
    //let regionRadius: Double = 1000
    
    //MARK: - IBOutlets
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var myTable: UITableView!
    
    //MARK: - IBActions
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
        
        myMap.delegate = self
        iniciaLocationManager()
        
        // Register the table view cell class and its reuse id
        myTable.register(UINib(nibName: "DMPendingDeliveryCellTableViewCell", bundle: nil), forCellReuseIdentifier: "DMPendingDeliveryCellTableViewCell")
        

    }
    
    func iniciaLocationManager(){
        
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            present(showAlert("Localización desactivada", mensaje: "Por favor, active la localización para esta aplicación en los ajustes del dispositivo", tituloAccion: "OK"), animated: true, completion: nil)
        default:
            if CLLocationManager.locationServicesEnabled() {
               
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.delegate = self
                locationManager.requestLocation()
                
                //Región = Mi localización, a 100 y 100 metros
                //myMapa.userLocation.coordinate necesita HABILITAR EL CHECK en el mainstoryboard para el mapa
                let region = MKCoordinateRegionMakeWithDistance(myMap.userLocation.coordinate, 100, 100)
                myMap.setRegion(myMap.regionThatFits(region), animated: true)
            }
        }
    }
    
    func showAlert(_ titulo: String, mensaje: String, tituloAccion: String) -> UIAlertController {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: tituloAccion, style: .default, handler: nil))
        return alert
    }
    
    
}

//MARK: - Extensions
extension DMPendingDelivery : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = myTable.dequeueReusableCell(withIdentifier: "DMPendingDeliveryCellTableViewCell") as! DMPendingDeliveryCellTableViewCell
        
      
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}


extension DMPendingDelivery : MKMapViewDelegate,CLLocationManagerDelegate{
 /*   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            centerMapOnUserLocation()
    }
    
    func centerMapOnUserLocation(){
        guard let coordinate = locationManager.location?.coordinate else{return}
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius*2.0, regionRadius * 2.0 )
        myMap.setRegion(coordinateRegion, animated: true)
        
    }
    
    func configureLocationServices(){
        if authorizationStatus == .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }else{
            return}
    } */
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("*** ERROR EN CORE LOCATION ***")
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         print("OK! Actualizada la localización")
    }
}
