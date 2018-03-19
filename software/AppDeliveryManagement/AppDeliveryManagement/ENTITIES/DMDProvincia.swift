//
//  DMDProvincia.swift
//  AppDeliveryManagement
//
//  Created by David Márquez Delgado on 20/3/18.
//  Copyright © 2018 David Márquez Delgado. All rights reserved.
//

import Foundation
class DMDProvincia {
    var id : Int
    var nombre : String
    var pais : DMDPais
    init(id: Int, nombre: String, pais: DMDPais) {
        self.id = id
        self.nombre = nombre
        self.pais = pais
    }

}
