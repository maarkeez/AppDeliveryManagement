//
//  DMDCiudad.swift
//  AppDeliveryManagement
//
//  Created by David Márquez Delgado on 20/3/18.
//  Copyright © 2018 David Márquez Delgado. All rights reserved.
//

import Foundation
class DMDCiudad {
    var id : Int
    var nombre : String
    var provincia : DMDProvincia
    
    init(id: Int, nombre: String, provincia: DMDProvincia) {
        self.id = id
        self.nombre = nombre
        self.provincia = provincia
    }
   
}
