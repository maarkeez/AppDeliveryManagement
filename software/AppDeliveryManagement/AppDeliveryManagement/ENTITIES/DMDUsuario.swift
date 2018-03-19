//
//  DMDUsuario.swift
//  AppDeliveryManagement
//
//  Created by David Márquez Delgado on 19/3/18.
//  Copyright © 2018 David Márquez Delgado. All rights reserved.
//

import Foundation
class DMDUsuario {
    var email : String
    var nombre : String
    var telefono : String
    
    
    init(email: String, nombre: String, telefono: String) {
        self.email = email
        self.nombre = nombre
        self.telefono = telefono
    }
}
