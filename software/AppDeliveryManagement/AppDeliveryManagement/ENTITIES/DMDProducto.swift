//
//  DMDProductos.swift
//  AppDeliveryManagement
//
//  Created by David Márquez Delgado on 20/3/18.
//  Copyright © 2018 David Márquez Delgado. All rights reserved.
//

import UIKit
class DMDProducto {
    var id : Int
    var nombre : String
    var descripcion : String
    var foto : UIImage?

    
    init(id: Int, nombre: String, descripcion: String) {
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
    }
    
    
    init(id: Int, nombre: String, descripcion: String, foto: UIImage?) {
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
        self.foto = foto
    }
}
