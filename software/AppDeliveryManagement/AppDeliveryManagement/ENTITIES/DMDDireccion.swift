//
//  DMDDireccion.swift
//  AppDeliveryManagement
//
//  Created by David Márquez Delgado on 19/3/18.
//  Copyright © 2018 David Márquez Delgado. All rights reserved.
//

import Foundation
class  DMDDireccion {
    var id : Int
    var cuidad  : DMDCiudad
    var CP : String
    var calle : String
    var piso : String
    
    init(id: Int,  cuidad: DMDCiudad, CP: String, calle: String, piso: String) {
        self.id = id
        self.cuidad = cuidad
        self.CP = CP
        self.calle = calle
        self.piso = piso
    }
    
    
}
