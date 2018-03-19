//
//  DMPedido.swift
//  AppDeliveryManagement
//
//  Created by David Márquez Delgado on 18/3/18.
//  Copyright © 2018 David Márquez Delgado. All rights reserved.
//

import Foundation
class DMDPedido {
    var id : Int
    var fechaPedido : Date
    var fechaEntrega : Date?
    var usuario : DMDUsuario
    var direccion : DMDDireccion
    var productos : [DMDProducto]
    
    init(id: Int, fechaPedido: Date,  usuario: DMDUsuario, direccion: DMDDireccion, productos: [DMDProducto]) {
        self.id = id
        self.fechaPedido = fechaPedido
        self.usuario = usuario
        self.direccion = direccion
        self.productos = productos
    }
    
    init(id: Int, fechaPedido: Date, fechaEntrega: Date?, usuario: DMDUsuario, direccion: DMDDireccion, productos: [DMDProducto]) {
        self.id = id
        self.fechaPedido = fechaPedido
        self.fechaEntrega = fechaEntrega
        self.usuario = usuario
        self.direccion = direccion
        self.productos = productos
    }
    
  
}
