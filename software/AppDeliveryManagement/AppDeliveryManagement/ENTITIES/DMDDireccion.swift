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
    var nombre : String
    var cuidad  : DMDCiudad
    var CP : String
    var calle : String
    var piso : String
    
    init(id: Int, nombre: String, cuidad: DMDCiudad, CP: String, calle: String, piso: String) {
        self.id = id
        self.nombre = nombre
        self.cuidad = cuidad
        self.CP = CP
        self.calle = calle
        self.piso = piso
    }
    
    
}
