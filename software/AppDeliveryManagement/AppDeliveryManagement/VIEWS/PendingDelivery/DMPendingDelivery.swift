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
    
    var pedidos = [DMDPedido]()
    
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
        
        pedidos = DMDPedidoService.shared.getToday()
       
        
    }
    
    func initAnnotations(){
            addAddressAnnotation(0)
    }
    
    func iniciaLocationManager(){
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            showAlert("Localización desactivada", mensaje: "Por favor, active la localización para esta aplicación en los ajustes del dispositivo", tituloAccion: "OK")
        default:
            if CLLocationManager.locationServicesEnabled() {
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.delegate = self
                locationManager.requestLocation()
            }
        }
    }
    
    func buildAlert(_ titulo: String, mensaje: String, tituloAccion: String) -> UIAlertController {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: tituloAccion, style: .default, handler: nil))
        return alert
    }
    
    func showAlert(_ titulo: String, mensaje: String, tituloAccion: String){
         present(buildAlert(titulo, mensaje: mensaje, tituloAccion: tituloAccion), animated: true, completion: nil)
    }
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    
    
    
}

//MARK: - Extensions
extension DMPendingDelivery : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "DMPendingDeliveryCellTableViewCell") as! DMPendingDeliveryCellTableViewCell
        
        cell.selectionStyle = .none
        
        let pedido = pedidos[indexPath.row]
        cell.myAdress.text = pedido.buildMapAdress()
        cell.myDeliveryId.text = pedido.buildStringId()
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedidos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Seleccionada: \(indexPath.row)")
    }
}


extension DMPendingDelivery : MKMapViewDelegate,CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("*** ERROR EN CORE LOCATION ***")
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last  {
            //Centrar el mapa
            let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 200, 200)
            myMap.setRegion(myMap.regionThatFits(region), animated: true)
            
            //Añadir pin
            let annotationCurrentLocation = MKPointAnnotation()
            annotationCurrentLocation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            myMap.addAnnotation(annotationCurrentLocation)
            print("OK! Creando pin para ubicacion actual.")
            initAnnotations()
        }
    }
    
    
    
    
    func addAddressAnnotation(_ pedidoIndex: Int){
        if pedidos.count <= pedidoIndex {
            return
        }
        
        let address = pedidos[pedidoIndex].buildMapAdress()
        
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                print("Error encontrando ubicacion: " + address)
                self.showAlert("Ubicacion no encontrada", mensaje: address, tituloAccion: "Continuar")
                
                
            }else if let placemarks = placemarks, (placemarks.count > 0) {
                print("Creando pin para ubicacion: " + address)

                let topResult: CLPlacemark = placemarks[0]
                let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                
                self.myMap.addAnnotation(placemark)
               
                if self.myMap.annotations.count == self.pedidos.count + 1 {
                    self.myMap.showAnnotations(self.myMap.annotations, animated: true)
                    print("Iniciando creación de ruta!")
                    self.showRouteOnMap(0)
                }
            }
            self.addAddressAnnotation(pedidoIndex + 1)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = generateRandomColor()
        
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    
    func showRouteOnMap(_ initAnnotationIndex: Int) {
        let annotations = myMap.annotations
        
        if annotations.count - 1 >=  initAnnotationIndex + 1 {
            let sourcePlacemark = MKPlacemark(coordinate: annotations[initAnnotationIndex].coordinate, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: annotations[initAnnotationIndex + 1].coordinate, addressDictionary: nil)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
            
            // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            
            directions.calculate {
                (response, error) -> Void in
                
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    
                    return
                }
                
                let route = response.routes[0]
                
                self.myMap.add((route.polyline), level: MKOverlayLevel.aboveRoads)
                
                let rect = route.polyline.boundingMapRect
                self.myMap.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
                self.showRouteOnMap(initAnnotationIndex + 1)
            }
        }
    }
}
